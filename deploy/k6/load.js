import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  scenarios: {
    load_test: {
      executor: 'ramping-vus',
      startVUs: 5,
      stages: [
        { duration: '2m', target: 20 },
        { duration: '3m', target: 20 },
        { duration: '2m', target: 0 },
      ],
    },
  },
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<400', 'p(99)<800'],
  },
};

const BASE_URL = __ENV.BASE_URL || 'http://internet-banking-api-gateway:8082';

export default function () {
  const res = http.get(`${BASE_URL}/actuator/health`);
  check(res, {
    'status is 200': (r) => r.status === 200,
  });
  sleep(1);
}
