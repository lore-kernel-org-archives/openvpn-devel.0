MIME-Version: 1.0
From: Lucas Mocellin <lucasmocellin@...277...>
Date: Wed, 17 Jun 2009 12:28:20 -0300
Message-ID: <edfc67860906170828l79b5eb55x22c28cc3f1cd00a9@...278...>
Content-Type: multipart/alternative; boundary=0016e6de016c1ede39046c8cf23a
Subject: [Openvpn-devel] maybe a bug in pkitool script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0016e6de016c1ede39046c8cf23a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I would like to inform/contribute with some situation I got now.

At first, I would like to change the "CA" directory from the
"clients/server" certificate because I want to use ./clean-all to refresh
the client certificates, and let the CA original, so I let vars with the
"clients" keys/certs and in the openssl.cnf I changed the CA location:

[ CA_default ]

# CHANGES TO AVOID ./clean-all TO DELETE CA
dirCA           = /etc/openvpn/2.0/ca
dir             = $ENV::KEY_DIR         # Where everything is kept
certs           = $dir                  # Where the issued certs are kept
crl_dir         = $dirCA                        # Where the issued crl are
kept
database        = $dirCA/index.txt      # database index file.
new_certs_dir   = $dir                  # default place for new certs.

certificate     = $dirCA/ca.crt         # The CA certificate
serial          = $dirCA/serial                 # The current serial number
crl             = $dirCA/crl.pem                # The current CRL
private_key     = $dirCA/ca.key         # The private key
RANDFILE        = $dirCA/.rand          # private random number file

In the "pkitool" script which comes with the openvpn, I noticed that when it
builds a new client/server cert he uses the openssl "-config openssl.cnf"
diretive(1), but to check if the CA exists, it uses the $KEY_DIR in vars(2).


(1)         # Build cert/key
        ( [ $DO_REQ -eq 0 ] || $OPENSSL req $BATCH -days $KEY_EXPIRE
$NODES_REQ -new -newkey rsa:$KEY_SIZE \
                -keyout "$KEY_CN.key" -out "$KEY_CN.csr" $REQ_EXT -config
"$KEY_CONFIG" $PKCS11_ARGS ) && \
            ( [ $DO_CA -eq 0 ]  || $OPENSSL ca $BATCH -days $KEY_EXPIRE -out
"$KEY_CN.crt" \
                -in "$KEY_CN.csr" $CA_EXT -md sha1 -config "$KEY_CONFIG" )
&& \
            ( [ $DO_P12 -eq 0 ] || $OPENSSL pkcs12 -export -inkey
"$KEY_CN.key" \
                -in "$KEY_CN.crt" -certfile "$CA.crt" -out "$KEY_CN.p12"
$NODES_P12 ) && \
            ( [ $DO_CA -eq 0 -o $DO_P11 -eq 1 ]  || chmod 0600 "$KEY_CN.key"
) && \
            ( [ $DO_P12 -eq 0 ] || chmod 0600 "$KEY_CN.p12" )


(2)         # Make sure CA key/cert is available
       if [ $DO_CA -eq 1 ] || [ $DO_P12 -eq 1 ]; then
           if [ ! -r "$CA.crt" ] || [ ! -r "$CA.key" ]; then
               echo "$PROGNAME: Need a readable $CA.crt and $CA.key in
$KEY_DIR"
               echo "Try $PROGNAME --initca to build a root
certificate/key."
               exit 1
           fi
       fi


Is that considered a bug?

Thanks in advance,

Lucas Mocellin.

--0016e6de016c1ede39046c8cf23a
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I would like to inform/contribute with some situation I got now.=
<br><br>At first, I would like to change the &quot;CA&quot; directory from =
the &quot;clients/server&quot; certificate because I want to use ./clean-al=
l to refresh the client certificates, and let the CA original, so I let var=
s with the &quot;clients&quot; keys/certs and in the openssl.cnf I changed =
the CA location:<br>

<br>[ CA_default ]<br><br># CHANGES TO AVOID ./clean-all TO DELETE CA<br>di=
rCA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D /etc/openvpn/2.0/ca<br>dir=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D $ENV::KEY_DIR=A0=A0=A0=A0=A0=A0=A0=A0 # Whe=
re everything is kept<br>certs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D $dir=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # Where the issued certs are =
kept<br>

crl_dir=A0=A0=A0=A0=A0=A0=A0=A0 =3D $dirCA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # Where the issued crl are kept<br>dat=
abase=A0=A0=A0=A0=A0=A0=A0 =3D $dirCA/index.txt=A0=A0=A0=A0=A0 # database i=
ndex file.<br>new_certs_dir=A0=A0 =3D $dir=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 # default place for new certs.<br>

<br>certificate=A0=A0=A0=A0 =3D $dirCA/ca.crt=A0=A0=A0=A0=A0=A0=A0=A0 # The=
 CA certificate<br>serial=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D $dirCA/serial=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # The current serial number<b=
r>crl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D $dirCA/crl.pem=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # The current CRL<br>private_key=A0=A0=A0=A0=
 =3D $dirCA/ca.key=A0=A0=A0=A0=A0=A0=A0=A0 # The private key<br>

RANDFILE=A0=A0=A0=A0=A0=A0=A0 =3D $dirCA/.rand=A0=A0=A0=A0=A0=A0=A0=A0=A0 #=
 private random number file<br><br>In the &quot;pkitool&quot; script which =
comes with the openvpn, I noticed that when it builds a new client/server c=
ert he uses the openssl &quot;-config openssl.cnf&quot; diretive(1), but to=
 check if the CA exists, it uses the $KEY_DIR in vars(2). <br>

<br>(1)=A0=A0=A0=A0=A0=A0=A0=A0 # Build cert/key<br>=A0=A0=A0=A0=A0=A0=A0 (=
 [ $DO_REQ -eq 0 ] || $OPENSSL req $BATCH -days $KEY_EXPIRE $NODES_REQ -new=
 -newkey rsa:$KEY_SIZE \<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=
keyout &quot;$KEY_CN.key&quot; -out &quot;$KEY_CN.csr&quot; $REQ_EXT -confi=
g &quot;$KEY_CONFIG&quot; $PKCS11_ARGS ) &amp;&amp; \<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ( [ $DO_CA -eq 0 ]=A0 || $OPENSSL ca $BAT=
CH -days $KEY_EXPIRE -out &quot;$KEY_CN.crt&quot; \<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 -in &quot;$KEY_CN.csr&quot; $CA_EXT -md sha1 -c=
onfig &quot;$KEY_CONFIG&quot; ) &amp;&amp; \<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ( [ $DO_P12 -eq 0 ] || $OPENSSL pkcs12 -export -inkey &quot;$KEY_CN.=
key&quot; \<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -in &quot;$KEY_CN.crt&quot; -=
certfile &quot;$CA.crt&quot; -out &quot;$KEY_CN.p12&quot; $NODES_P12 ) &amp=
;&amp; \<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ( [ $DO_CA -eq 0 -o $DO_P11 -=
eq 1 ]=A0 || chmod 0600 &quot;$KEY_CN.key&quot; ) &amp;&amp; \<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ( [ $DO_P12 -eq 0 ] || chmod 0600 &quot;$=
KEY_CN.p12&quot; )<br><br><br>(2)=A0=A0=A0=A0=A0=A0=A0=A0 # Make sure CA ke=
y/cert is available<br>=A0=A0=A0=A0=A0=A0 if [ $DO_CA -eq 1 ] || [ $DO_P12 =
-eq 1 ]; then<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ ! -r &quot;$CA.crt&quo=
t; ] || [ ! -r &quot;$CA.key&quot; ]; then<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo &quot;$PROGNAME: Need a rea=
dable $CA.crt and $CA.key in $KEY_DIR&quot;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 echo &quot;Try $PROGNAME --initca to build a root certifica=
te/key.&quot;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit 1<br>=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 fi<br>

=A0=A0=A0=A0=A0=A0 fi<br><br><br>Is that considered a bug?<br><br>Thanks in=
 advance,<br><br>Lucas Mocellin.<br>

--0016e6de016c1ede39046c8cf23a--

