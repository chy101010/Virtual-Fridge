#!/bin/bash

export MIX_ENV=prod
export PORT=4800

CFGD=$(readlink -f ~/.config/cooking_app)

if [ ! -e "$CFGD/base" ]; then
		            echo "run deploy first"
			    		                exit 1
fi

DB_PASS=$(cat "$CFGD/db_pass")
export DATABASE_URL=ecto://cooking_app_user:$DB_PASS@localhost/cooking_app_prod

SECRET_KEY_BASE=$(cat "$CFGD/base")
export SECRET_KEY_BASE

_build/prod/rel/cooking_app/bin/cooking_app start
