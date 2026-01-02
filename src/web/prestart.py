"""
Pre-start hook for the FastCVE app container.

Ensures environment is loaded and DB schema is migrated to the latest Alembic head
before the web server starts.
"""

import time

from common.util import setup_env, init_db_schema


def main() -> None:
    setup_env()

    last_exc: Exception | None = None
    for _ in range(60):
        try:
            init_db_schema()
            return
        except Exception as exc:  # pragma: no cover
            last_exc = exc
            time.sleep(1)

    if last_exc:  # pragma: no cover
        raise last_exc


if __name__ == "__main__":
    main()
