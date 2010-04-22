From: Davide Brini <dave_br@...1278...>
Date: Thu, 22 Apr 2010 21:53:28 +0100
References: <20100422111337.7ABB521DCF7@...1353...>
	<4BD07777.5030805@...1114...>
	<201004221829.13824.dave_br@...1278...>
In-Reply-To: <201004221829.13824.dave_br@...1278...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IdL0L8dF6gkET8C"
Message-Id: <201004222153.28610.dave_br@...1278...>
Subject: [Openvpn-devel] [PATCH] revocation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Boundary-00=_IdL0L8dF6gkET8C
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

(moving to -devel as this is obviously pertains there more than -users)

On Thursday 22 April 2010, Davide Brini wrote:

> > > RFC 5280 says that "certificate users MUST be able to handle
> > > serialNumber values up to 20 octets", so a 16-byte value looks valid to
> > > me. I would say (without looking at the code) that it's OpenVPN that
> > > can't handle it and gives -1 to the user. However I'm performing some
> > > further
> > > verification, and will report back if I find something.
> >
> > Please do!  However, beware that this RFC separates 'certificate serial
> > number' and 'serial number'.  Which is probably why the confusion is all
> > present.  The specification also uses the ASN1 INTEGER definition,
> > AFAICU.  But I don't recall the expected size of those integer values,
> > but I believe it is 32bit in OpenSSL (that's what ASN1_INTEGER_get()
> > returns).  Going to the extreme, I don't think that ASN1 sets any
> > boundary on the min/max values of INTEGER - which makes it quite
> > interesting.
> >
> > You might want to try to patch ssl.c with a better suitable type in
> > ssl.c.  Have a look around line 850.  You could try to use 'unsigned
> > long int' and change the %d to %ld, or whatever the compiler accepts for
> > unsigned long int.  From what I can understand, ASN1_INTEGER_get()
> > should be correct.
> >
> > long is usually 32bit (4 bytes).  Making it unsigned gives you the 32th
> >  bit.

Ok, so I'm looking into the sources of openssl. ASN1_INTEGER is a typedef for 
"struct asn1_string_st"; and the comments in the code for that structure are 
quite explicit:

-------------------------------------------------
/* This is the base type that holds just about everything :-) */
typedef struct asn1_string_st
    {
    int length;
    int type;
    unsigned char *data;
    /* The value of the following field depends on the type being
     * held.  It is mostly being used for BIT_STRING so if the
     * input data has a non-zero 'unused bits' value, it will be
     * handled correctly */
    long flags;
    } ASN1_STRING;
-------------------------------------------------

So an ASN1_INTEGER in OpenSSL can really contain arbitrarily long values (many 
other types are typedef'd to "struct asn1_string_st").

More to the point, when one runs "openssl x509 -text", it turns out that it 
explicitly checks for the serial number's length. If it's up to 4 bytes, it's 
printed like

        Serial Number: 927650371 (0x374ad243)
 
if instead it's longer, it's printed in the form

        Serial Number:
            05:40:69:bf:0f:c2:4f:f4:b0:05:ee:95:3f:18:71:17

(crypto/asn1/t_x509.c, line 138 and following), which confirms my initial 
guess. So in fact it's just a different output format, and the serial number 
is just an (almost) arbitrarily large number. Why would a CA choose such a 
serial number? I don't know, it's their business but we should be able to 
handle it.

Sorry for the - somewhat - OT introduction, but I felt it was necessary to 
clarify the puzzling output I was seeing earlier. Now let's turn to OpenVPN.

ssl.c, line 789:

-------------------------------------------------
 /* export serial number as environmental variable */
const int serial = (int) ASN1_INTEGER_get (X509_get_serialNumber (ctx-
>current_cert));
-------------------------------------------------

Here is ASN1_INTEGER_get (from openssl's crypto/asn1/a_int.c, line 376):

-------------------------------------------------
long ASN1_INTEGER_get(ASN1_INTEGER *a)
    {
    int neg=0,i;
    long r=0;

    if (a == NULL) return(0L);
    i=a->type;
    if (i == V_ASN1_NEG_INTEGER)
        neg=1;
    else if (i != V_ASN1_INTEGER)
        return -1;

    if (a->length > (int)sizeof(long))
        {
        /* hmm... a bit ugly */
        return(0xffffffffL);
        }
    if (a->data == NULL)
        return 0;

    for (i=0; i<a->length; i++)
        {
        r<<=8;
        r|=(unsigned char)a->data[i];
        }
    if (neg) r= -r;
    return(r);
    }
-------------------------------------------------

and that explains why we get -1 with big serial numbers on 32 bit.

Now, it seems that the "right" fix for OpenVPN would be to use a memory BIO 
object as explained in the docs. That way, the serial number is "printed" to 
the BIO object and can be read back into an array of characters. In that form, 
it could be exported into the environment using setenv_str() instead of 
setenv_int() (environment variables are all strings anyway). Also, due to the 
way i2a_ASN1_INTEGER() prints stuff, it will be a long hexadecimal string, 
which integrates nicely with OCSP, so it is ready to use when doing OCSP 
queries (by doing '-serial "0x${tls_serial_0}"' etc.)

So here's a patch that does exactly that; it's quite straightforward in fact. 
I have tested it on two Gentoo boxes and it seems to work fine, although of 
course more testing never hurts; here's a dump of the serial numbers in a full 
certificate chain:

054069bf0fc24ff4b005ee953f187117
0851F959814145CABDE124E232C9D20E
428740A5
374AD243

I produced that with a simple tls-verify script that dumps 
$tls_serial_{0,1,2,3}.

Well, enough blathering (sorry!); here's the patch. It's also attached 
separately in the likely case that line wrapping mess up the inline version.

Description: correctly manage serial numbers of any size (as long as OpenSSL 
can manage them) to be exported as environment variables for children scripts.

--- openvpn-2.1.1/ssl.c 2010-02-28 22:17:45.000000000 +0000
+++ openvpn-2.1.1-a/ssl.c       2010-04-22 21:26:45.000000000 +0100
@@ -788,9 +788,25 @@ verify_callback (int preverify_ok, X509_

   /* export serial number as environmental variable */
   {
-    const int serial = (int) ASN1_INTEGER_get (X509_get_serialNumber (ctx-
>current_cert));
+    BIO *bio = NULL;
+    char serial[1024] = {0};
+    int n;
+
+    if ((bio = BIO_new (BIO_s_mem ())) == NULL) {
+      msg (M_FATAL, "CALLBACK: Cannot create BIO");
+    }
+    /* "prints" the serial number onto the BIO */
+    i2a_ASN1_INTEGER(bio, X509_get_serialNumber (ctx->current_cert));
+    n = BIO_read (bio, serial, sizeof (serial)-1);
+    if (n < 0) {
+      serial[0] = '\x0';
+    }
+    else {
+      serial[n] = 0;
+    }
+
     openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", ctx-
>error_depth);
-    setenv_int (opt->es, envname, serial);
+    setenv_str (opt->es, envname, serial);
   }

   /* export current untrusted IP */

-- 
D.

--Boundary-00=_IdL0L8dF6gkET8C
Content-Type: text/x-patch; charset="UTF-8"; name="long_serial_numbers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="long_serial_numbers.patch"

--- openvpn-2.1.1/ssl.c	2010-02-28 22:17:45.000000000 +0000
+++ openvpn-2.1.1-a/ssl.c	2010-04-22 21:26:45.000000000 +0100
@@ -788,9 +788,25 @@ verify_callback (int preverify_ok, X509_
 
   /* export serial number as environmental variable */
   {
-    const int serial = (int) ASN1_INTEGER_get (X509_get_serialNumber (ctx->current_cert));
+    BIO *bio = NULL;
+    char serial[1024] = {0};
+    int n;
+
+    if ((bio = BIO_new (BIO_s_mem ())) == NULL) {
+      msg (M_FATAL, "CALLBACK: Cannot create BIO");
+    }
+    /* "prints" the serial number onto the BIO */
+    i2a_ASN1_INTEGER(bio, X509_get_serialNumber (ctx->current_cert));
+    n = BIO_read (bio, serial, sizeof (serial)-1);
+    if (n < 0) {
+      serial[0] = '\x0';
+    }
+    else {
+      serial[n] = 0;
+    }
+    
     openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", ctx->error_depth);
-    setenv_int (opt->es, envname, serial);
+    setenv_str (opt->es, envname, serial);
   }
 
   /* export current untrusted IP */

--Boundary-00=_IdL0L8dF6gkET8C--

