Message-ID: <4C2474EC.6000308@...1380...>
Date: Fri, 25 Jun 2010 11:20:44 +0200
From: Emilien Mantel <emilien.mantel@...1380...>
MIME-Version: 1.0
References: <4C19ED93.50202@...1380...>	<4C1A0941.5000808@...515...>	<AANLkTinkGgRbX7tY0QZzoC-ru5jhKFdpiEgn-proJecI@...278...>	<4C1A1AE1.5090305@...1380...>	<AANLkTimpz7YASaTfmQ5DItwiMrplAx_G93ez2vHxAWW5@...278...>	<4C1A3658.6090501@...1380...>	<4C1A7E26.4010206@...1114...>
	<20100618000120.28120.qmail@...1287...>
In-Reply-To: <20100618000120.28120.qmail@...1287...>
Content-Type: multipart/mixed; boundary="------------060201030904000505080702"
Subject: Re: [Openvpn-devel] [PATCH] Choose a different field in X509 to	be
 username
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
--------------060201030904000505080702
X-MIME-Autoconverted: from 8bit to quoted-printable by
	edd-bd-mesg-ldap-01.eolas-services.com id o5P9KGtZ001902
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

See attached a very small patch (based on allmerged tree) to fix "sizeof".

Regards,

--
Emilien Mantel

Le 18/06/2010 02:01, Peter Stuge a =E9crit :
> David Sommerseth wrote:
>=20=20=20=20
>>> 3) "sizeof(common_name)" is useless... Line 745: char
>>> common_name[TLS_USERNAME_LEN]; we can use directly TLS_USERNAME_LEN.
>>>=20=20=20=20=20=20=20=20
>> Thanks a lot for the patch and all rework done.  (Also: thank you to all
>> reviewers!)
>>
>> The third and last patch looks very good!  I've applied it to the
>> feat_misc branch and merged it into allmerged.
>>=20=20=20=20=20=20
> I strongly agree with Alon about sizeof() rather than a second
> reference to the same define. It is the defensive way.
>
>
> //Peter
>
> -------------------------------------------------------------------------=
-----
> ThinkGeek and WIRED's GeekDad team up for the Ultimate
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
> lucky parental unit.  See the prize list and enter to win:
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=20=20=20


--------------060201030904000505080702
Content-Type: text/x-patch;
 name="small-patch.diff"
Content-Disposition: attachment;
 filename="small-patch.diff"
Content-Transfer-Encoding: 7bit

diff --git a/ssl.c b/ssl.c
index f6e2410..8c7a5ee 100644
--- a/ssl.c
+++ b/ssl.c
@@ -779,7 +779,7 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   string_replace_leading (subject, '-', '_');
 
   /* extract the username (default is CN) */
-  if (!extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert), x509_username_field, common_name, TLS_USERNAME_LEN))
+  if (!extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert), x509_username_field, common_name, sizeof(common_name)))
     {
       if (!ctx->error_depth)
         {

--------------060201030904000505080702--

