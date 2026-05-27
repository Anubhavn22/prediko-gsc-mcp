FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim
WORKDIR /app

# Copy dependency files first for layer caching — deps only reinstall when these change
COPY pyproject.toml README.md ./
RUN uv sync --no-cache --no-install-project

# Copy application code
COPY gsc_server.py .

# SSE transport defaults — all can be overridden via Railway env vars
ENV MCP_TRANSPORT=sse
ENV FASTMCP_HOST=0.0.0.0
ENV FASTMCP_PORT=3001
ENV GSC_SKIP_OAUTH=true
ENV GSC_DATA_STATE=all

EXPOSE 3001

CMD ["uv", "run", "--no-sync", "python", "gsc_server.py"]
