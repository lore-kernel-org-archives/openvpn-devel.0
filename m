From: "Johnny C. Lam" <jlam@...438...>
Message-ID: <20050817171707.GA39058@...440...>
References: <Pine.LNX.4.58.0508161354420.10152@...41...> <ddtt8m$41j$1@...165...> <Pine.LNX.4.58.0508170649000.15439@...41...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508170649000.15439@...41...>
Subject: [Openvpn-devel] portable pkitool shell script [was OpenVPN 2.0.1 released -- note security fixes]
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Aug 17 10:18:01 2005
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 17, 2005 at 06:52:50AM -0600, James Yonan wrote:
> On Tue, 16 Aug 2005, Johnny Lam wrote:
> 
> > James Yonan wrote:
> > >
> > > * Added easy-rsa 2.0 scripts to the tarball in easy-rsa/2.0
> > 
> > I am maintaining OpenVPN in the NetBSD Packages Collection and was in 
> > the process of updating our package to 2.0.1 when I noticed that the 
> > pkitool script uses bash.  If I provide them, will patches be accepted 
> > into the OpenVPN sources to use Bourne shell syntax instead so as to 
> > relax the requirement on bash?
> 
> Yes, that's probably okay.  Hopefully we can get bash/sh portability 
> without complexifying the code too much.

I've attached a patch that does the following things:

    (1) Bourne shell fix: function foo {...}  ->  foo() {...}

    (2) Bourne shell fix: avoid use of bash's substring selection
	${foo:M:N} by replacing with an equivalent options-processing
	loop.

    (3) Solaris /bin/sh fix: don't set and export in one command;
	rather, export all the variables after setting them.

    (4) Solaris /bin/sh fix: "if ! cmd ; then ... fi" isn't understood,
	so change it to "if cmd; then :; else ... fi".

    (5) Don't require GNU grep -- -E isn't needed since we're matching
	a basic RE, and -q can be avoided by attaching stdout to
	/dev/null.

    (6) Use GREP and OPENSSL variables instead of "grep" and "openssl"
	so that it's easier to hard-code the full paths to the two
	utilities in the pkitool script by setting them at the top of
	the script.

I've tested this script on both NetBSD 2.0.2 and Solaris 8.

	Cheers,

	-- Johnny Lam <jlam@...438...>

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn.patch"

--- easy-rsa/2.0/README.orig	2005-07-17 16:13:42.000000000 -0400
+++ easy-rsa/2.0/README
@@ -46,9 +46,6 @@ Release Notes for easy-rsa-2.0
 
 * This release only affects the Linux/Unix version of easy-rsa.
   The Windows version (written to use the Windows shell) is unchanged.
-  Note that the new pkitool script is written in bash, and will not
-  run on Windows unless bash is installed.  To install bash on Windows,
-  see the MSYS package available here: http://www.mingw.org/
 
 INSTALL easy-rsa
 
--- easy-rsa/2.0/pkitool.orig	2005-07-15 14:38:14.000000000 -0400
+++ easy-rsa/2.0/pkitool
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 #  OpenVPN -- An application to securely tunnel IP networks
 #             over a single TCP/UDP port, with support for SSL/TLS-based
@@ -31,7 +31,10 @@ PROGNAME=pkitool
 VERSION=2.0
 DEBUG=0
 
-function need_vars
+GREP=grep
+OPENSSL=openssl
+
+need_vars()
 {
     echo '  Please edit the vars script to reflect your configuration,'
     echo '  then source it with "source ./vars".'
@@ -40,7 +43,7 @@ function need_vars
     echo "  Finally, you can run this tool ($PROGNAME) to build certificates/keys."
 }
 
-function usage
+usage()
 {
     echo "$PROGNAME $VERSION"
     echo "Usage: $PROGNAME [options...] [common-name]"
@@ -103,7 +106,7 @@ BATCH="-batch"
 CA="ca"
 
 # Process options
-while [ "$1" ] && [ "${1:0:2}" = "--" ]; do
+while [ $# -gt 0 ]; do
     case "$1" in
 	--server   ) REQ_EXT="$REQ_EXT -extensions server"
 	             CA_EXT="$CA_EXT -extensions server" ;;
@@ -115,8 +118,9 @@ while [ "$1" ] && [ "${1:0:2}" = "--" ];
         --csr      ) DO_CA="0" ;;
         --sign     ) DO_REQ="0" ;;
         --pkcs12   ) DO_P12="1" ;;
-	*  )       echo "$PROGNAME: unknown option: $1"
-	           exit 1
+	--*        ) echo "$PROGNAME: unknown option: $1"
+	             exit 1 ;;
+	*          ) break ;;
     esac
     shift   
 done
@@ -128,25 +132,25 @@ if [ $DO_P12 -eq 1 ]; then
 fi
 
 # If undefined, set default key expiration intervals
-if [ -z $KEY_EXPIRE ]; then
-    export KEY_EXPIRE=3650
+if [ -z "$KEY_EXPIRE" ]; then
+    KEY_EXPIRE=3650
 fi
-if [ -z $CA_EXPIRE ]; then
-    export CA_EXPIRE=3650
+if [ -z "$CA_EXPIRE" ]; then
+    CA_EXPIRE=3650
 fi
 
 # Set organizational unit to empty string if undefined
 if [ -z "$KEY_OU" ]; then
-    export KEY_OU=""
+    KEY_OU=""
 fi
 
 # Set KEY_CN
 if [ $DO_ROOT -eq 1 ]; then
     if [ -z "$KEY_CN" ]; then
 	if [ "$1" ]; then
-	    export KEY_CN="$1"
+	    KEY_CN="$1"
 	elif [ "$KEY_ORG" ]; then
-	    export KEY_CN="$KEY_ORG CA"
+	    KEY_CN="$KEY_ORG CA"
 	fi
     fi
     if [ $BATCH ] && [ "$KEY_CN" ]; then
@@ -159,9 +163,10 @@ else
 	usage
 	exit 1
     else
-	export KEY_CN="$1"
+	KEY_CN="$1"
     fi
 fi
+export CA_EXPIRE KEY_EXPIRE KEY_OU KEY_CN
 
 # Show parameters (debugging)
 if [ $DEBUG -eq 1 ]; then
@@ -186,7 +191,9 @@ if [ -d "$KEY_DIR" ] && [ "$KEY_CONFIG" 
 
     # Make sure $KEY_CONFIG points to the correct version
     # of openssl.cnf
-    if ! grep -Eqi 'easy-rsa version 2\.[0-9]' "$KEY_CONFIG" ; then
+    if $GREP -i 'easy-rsa version 2\.[0-9]' "$KEY_CONFIG" >/dev/null; then
+	:
+    else
 	echo "$PROGNAME: KEY_CONFIG (set by the ./vars script) is pointing to the wrong"
         echo "version of openssl.cnf: $KEY_CONFIG"
 	echo "The correct version should have a comment that says: easy-rsa version 2.x";
@@ -195,7 +202,7 @@ if [ -d "$KEY_DIR" ] && [ "$KEY_CONFIG" 
 
     # Build root CA
     if [ $DO_ROOT -eq 1 ]; then
-	openssl req $BATCH -days $CA_EXPIRE $NODES_REQ -new -x509 \
+	$OPENSSL req $BATCH -days $CA_EXPIRE $NODES_REQ -new -x509 \
 	    -keyout "$CA.key" -out "$CA.crt" -config "$KEY_CONFIG" && \
 	    chmod 0600 "$CA.key"
     else        
@@ -209,11 +216,11 @@ if [ -d "$KEY_DIR" ] && [ "$KEY_CONFIG" 
 	fi
 
         # Build cert/key
-	( [ $DO_REQ -eq 0 ] || openssl req $BATCH -days $KEY_EXPIRE $NODES_REQ -new \
+	( [ $DO_REQ -eq 0 ] || $OPENSSL req $BATCH -days $KEY_EXPIRE $NODES_REQ -new \
 	        -keyout "$KEY_CN.key" -out "$KEY_CN.csr" $REQ_EXT -config "$KEY_CONFIG" ) && \
-	    ( [ $DO_CA -eq 0 ]  || openssl ca $BATCH -days $KEY_EXPIRE -out "$KEY_CN.crt" \
+	    ( [ $DO_CA -eq 0 ]  || $OPENSSL ca $BATCH -days $KEY_EXPIRE -out "$KEY_CN.crt" \
 	        -in "$KEY_CN.csr" $CA_EXT -config "$KEY_CONFIG" ) && \
-	    ( [ $DO_P12 -eq 0 ] || openssl pkcs12 -export -inkey "$KEY_CN.key" \
+	    ( [ $DO_P12 -eq 0 ] || $OPENSSL pkcs12 -export -inkey "$KEY_CN.key" \
 	        -in "$KEY_CN.crt" -certfile "$CA.crt" -out "$KEY_CN.p12" $NODES_P12 ) && \
 	    ( [ $DO_CA -eq 0 ]  || chmod 0600 "$KEY_CN.key" ) && \
 	    ( [ $DO_P12 -eq 0 ] || chmod 0600 "$KEY_CN.p12" )

--yrj/dFKFPuw6o+aM--

