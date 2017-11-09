+#!/bin/bash
+
+STATUS=502
+
+until [ $STATUS -eq 200 ]; do
+	echo -e ".\c"
+	STATUS=$(sleep 1 && curl -LI $@ -o /dev/null -w '%{http_code}\n' -s)
+done
+
+echo ""
#exit with zero (success) - http://tldp.org/LDP/abs/html/exitcodes.html 
+exit 0
