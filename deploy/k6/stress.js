import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  scenarios: {
    stress_test: {
      executor: 'ramping-vus',
      startVUs: 10,
      stages: [
        { duration: '2m', target: 30 },
        { duration: '3m', target: 60 },
        { duration: '2m', target: 90 },
        { duration: '2m', target: 0 },
      ],
    },
  },
  thresholds: {
    http_req_failed: ['rate<0.02'],
    http_req_duration: ['p(95)<700', 'p(99)<1200'],
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
