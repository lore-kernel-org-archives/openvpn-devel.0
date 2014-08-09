Message-ID: <53E6A61C.7010106@...1856...>
Date: Sun, 10 Aug 2014 00:52:12 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1403983176-27674-1-git-send-email-steffan@...1856...>	<53B1BDD8.8020705@...1856...>
	<53BBA8F9.30004@...1839...>
In-Reply-To: <53BBA8F9.30004@...1839...>
Content-Type: multipart/mixed; boundary="------------080406050104070205020702"
Subject: Re: [Openvpn-devel] [PATCH] Do not upcase x509-username-field for
 mixed-case arguments.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080406050104070205020702
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi Andris

On 08-07-14 10:16, Kalnozols, Andris wrote:
> Regarding the "ext:" argument prefix, I had submitted an enhanced
> version of extract_x509_extension() mainly for more helpful log
> messages.

I finally had some time to look at those changes (for other, see
https://community.openvpn.net/openvpn/ticket/402 for the patch), but
while figuring out the impact of the changes, I managed to make it
segfault by running

openvpn --config sample-config-files/loopback-server
--x509-username-field "ext:authorityKeyIdentifier"

and make a client connect using

openvpn --config sample-config-files/loopback-client

The culprit was in i2v_GENERAL_NAMES(), but I decided not to dive in any
further and go for your second option:

> If it doesn't pass muster, then I would suggest that
> this function be at least changed as follows:
> 
>                     }
>                   break;
>                 default:
> -                 msg (D_TLS_ERRORS, "ASN1 ERROR: can not handle field
> type %i",
> +                 msg (D_TLS_DEBUG, "Ignoring name field type %i",
>                        name->type);
>                   break;
>               }
> 
> I don't see the need for alarm if an extension field has additional
> GeneralName field types other than "email".

I completely agree. Attached a patch that does just that. I changed the
message a bit, but I guess I can still ACK this. So, ACK :)

-Steffan

--------------080406050104070205020702
Content-Type: text/x-patch;
	name="0001-extract_x509_extension-hide-status-message-during-no.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-extract_x509_extension-hide-status-message-during-no.pa";
	filename*1="tch"

=46rom 6170243b318cade1ca905e4a3b7a62faaeada755 Mon Sep 17 00:00:00 2001
From: Andris Kalnozols <andris@...1839...>
Date: Sun, 10 Aug 2014 00:40:44 +0200
Subject: [PATCH] extract_x509_extension(): hide status message during nor=
mal
 operation.

For each recognized extension in a certificate, extract_x509_extension()
would issue an "ASN1 ERROR: can not handle field type" debug message at
verb 2. Reduce that to verb 9 (D_TLS_ERRORS -> D_TLS_DEBUG) and alter the=

message text accordingly.

Signed-off-by: Andris Kalnozols <andris@...1839...>
Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify_openssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
index cbcff02..56e1c11 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -140,8 +140,8 @@ bool extract_x509_extension(X509 *cert, char *fieldna=
me, char *out, int size)
                   }
                 break;
               default:
-                msg (D_TLS_ERRORS, "ASN1 ERROR: can not handle field typ=
e %i",
-                     name->type);
+                msg (D_TLS_DEBUG, "%s: ignoring general name field type =
%i",
+                    __func__, name->type);
                 break;
             }
           }
--=20
1.9.1


--------------080406050104070205020702--

