From: chantra <chantra@...1258...>
In-Reply-To: <4D036D80.20409@...1114...>
References: <4D036D80.20409@...1114...>
Content-Type: multipart/mixed; boundary="=-MhRxM79CiG3rg0Sc9171"
Date: Sat, 11 Dec 2010 18:49:15 +0100
Message-ID: <1292089756.2743.69.camel@...1259...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] Feature branch drop warning - --passtos and
	VLAN patch set
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Davide Guerri <dguerri@...384...>

--=-MhRxM79CiG3rg0Sc9171
Content-Type: multipart/alternative; boundary="=-twNCOgln/wfE+4R+GGJ1"

--=-twNCOgln/wfE+4R+GGJ1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



> I personally see the a broader use case for the VLAN patches, and I would
> *not* like to throw out the VLAN patches in addition.  So I therefore see just
> a few solutions.  I would like to see the VLAN patches go into OpenVPN 2.3.
> 
> *a)* --passtos gets serious testing with responses *back to the mailing list*.
> We need to know if this patch has any side-effects to users who do not use
> this feature.  It needs to be validated that the patch itself does work properly.
> 

I do not have any TAP setting running so I cant really test that, but
looking at the patch I do not see any side effect
for people not using the feature.

What it does is to check if the protocol encapsulated in ethernet frame
is 802.1Q and apply the logic behind it.
If not, check if it is a IPv4 packet encapsulated and do the usual
logic.

The only point that would get my attention is kind of silly, but instead
of testing VLAN type first, I would rather test IPv4 type first.

As obviously most people use IPv4 only, it makes more sense to stop the
"if then else if" part as early as possible to avoid useless test.
Thus, the patch might look more like the one attached to this email.
Where the logic is:
if IPv4 encapsulated:
  get_offset_for_packet
else if 802.1Q:
  if IPv4 encapsulated in 802.1Q:
    get_offset_for_tagged_packet
  else:
    return false
else:
  return false

Now, as said earlier, it seems this patch will not affect people not
using VLAN feature.
I would not be able to tell if it works though :s



> *b)* Fabian Knittel embraces the pieces he needs from the --passtos patch to
> his VLAN patches, thus becoming independent of --passtos.  This might require
> some restructuring of Fabians feature branch and replacing the current one
> with a new feat_vlan_tagging branch.
> 
> Fabian: Can you please also provide us with some testing instructions?
> Including how to set it up and how to validate things works.  And also here we
> need to test that this works for both users enabling and not enabling this
> feature.

This patch is based on the previous one, so I guess it confirms the
feature from Davide works.
It is indeed a feature I find useful (even though i dont use it
myself :) ).
Same here, I cant really try this that easily and intensively as I dont
have any infrastructure using TAP.
But I would say +1 to the feature.

Hopefully, this will kick in the thread, avoiding c) ;)

BR,

Chantra


> *c)* To drop --passtos and the VLAN patches completely.  This is the choice I
> really want to try to avoid.
> 
> 
> I would really like to have this solved before *mid January* - which means
> approx. 5-6 weeks.  If silence continues to rule, I am forced to kick them out
> - - as these patches are based on an older 2.1 release and we are planning a 2.2
> release in January.
> 
> *If* we get these features tested and confirmed, these patches will be
> considered for the OpenVPN 2.3 release.
> 
> 
> kind regards,
> 
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAk0DbYAACgkQDC186MBRfrrFDQCfTZr1rzoGE8CeBhWcMfEEK/HP
> AMsAn2eRm7pgf0w60tpjweA6XQ5uBtbf
> =YI92
> -----END PGP SIGNATURE-----
> 
> ------------------------------------------------------------------------------
> Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
> new data types, scalar functions, improved concurrency, built-in packages, 
> OCI, SQL*Plus, data movement tools, best practices and more.
> http://p.sf.net/sfu/oracle-sfdev2dev 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


-- 
http://www.debuntu.org

--=-twNCOgln/wfE+4R+GGJ1
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.30.3">
</HEAD>
<BODY>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
I personally see the a broader use case for the VLAN patches, and I would
*not* like to throw out the VLAN patches in addition.  So I therefore see just
a few solutions.  I would like to see the VLAN patches go into OpenVPN 2.3.

*a)* --passtos gets serious testing with responses *back to the mailing list*.
We need to know if this patch has any side-effects to users who do not use
this feature.  It needs to be validated that the patch itself does work properly.

</PRE>
</BLOCKQUOTE>
I do not have any TAP setting running so I cant really test that, but looking at the patch I do not see any side effect<BR>
for people not using the feature.<BR>
<BR>
What it does is to check if the protocol encapsulated in ethernet frame is 802.1Q and apply the logic behind it.<BR>
If not, check if it is a IPv4 packet encapsulated and do the usual logic.<BR>
<BR>
The only point that would get my attention is kind of silly, but instead of testing VLAN type first, I would rather test IPv4 type first.<BR>
<BR>
As obviously most people use IPv4 only, it makes more sense to stop the &quot;if then else if&quot; part as early as possible to avoid useless test.<BR>
Thus, the patch might look more like the one attached to this email.<BR>
Where the logic is:<BR>
if IPv4 encapsulated:<BR>
&nbsp; get_offset_for_packet<BR>
else if 802.1Q:<BR>
&nbsp; if IPv4 encapsulated in 802.1Q:<BR>
&nbsp;&nbsp;&nbsp; get_offset_for_tagged_packet<BR>
&nbsp; else:<BR>
&nbsp;&nbsp;&nbsp; return false<BR>
else:<BR>
&nbsp; return false<BR>
<BR>
Now, as said earlier, it seems this patch will not affect people not using VLAN feature.<BR>
I would not be able to tell if it works though :s<BR>
<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
*b)* Fabian Knittel embraces the pieces he needs from the --passtos patch to
his VLAN patches, thus becoming independent of --passtos.  This might require
some restructuring of Fabians feature branch and replacing the current one
with a new feat_vlan_tagging branch.

Fabian: Can you please also provide us with some testing instructions?
Including how to set it up and how to validate things works.  And also here we
need to test that this works for both users enabling and not enabling this
feature.
</PRE>
</BLOCKQUOTE>
This patch is based on the previous one, so I guess it confirms the feature from Davide works.<BR>
It is indeed a feature I find useful (even though i dont use it myself :) ).<BR>
Same here, I cant really try this that easily and intensively as I dont have any infrastructure using TAP.<BR>
But I would say +1 to the feature.<BR>
<BR>
Hopefully, this will kick in the thread, avoiding c) ;)<BR>
<BR>
BR,<BR>
<BR>
Chantra<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
*c)* To drop --passtos and the VLAN patches completely.  This is the choice I
really want to try to avoid.


I would really like to have this solved before *mid January* - which means
approx. 5-6 weeks.  If silence continues to rule, I am forced to kick them out
- - as these patches are based on an older 2.1 release and we are planning a 2.2
release in January.

*If* we get these features tested and confirmed, these patches will be
considered for the OpenVPN 2.3 release.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - <A HREF="http://enigmail.mozdev.org/">http://enigmail.mozdev.org/</A>

iEYEARECAAYFAk0DbYAACgkQDC186MBRfrrFDQCfTZr1rzoGE8CeBhWcMfEEK/HP
AMsAn2eRm7pgf0w60tpjweA6XQ5uBtbf
=YI92
-----END PGP SIGNATURE-----

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
<A HREF="http://p.sf.net/sfu/oracle-sfdev2dev">http://p.sf.net/sfu/oracle-sfdev2dev</A> 
_______________________________________________
Openvpn-devel mailing list
<A HREF="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</A>
<A HREF="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</A>

</PRE>
</BLOCKQUOTE>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<PRE>
-- 
<A HREF="http://www.debuntu.org">http://www.debuntu.org</A>
</PRE>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-twNCOgln/wfE+4R+GGJ1--

--=-MhRxM79CiG3rg0Sc9171
Content-Disposition: attachment;
	filename="0001-Modified-version-of-VLAN-patch.patch"
Content-Type: text/x-patch; name="0001-Modified-version-of-VLAN-patch.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

From acaeeb006a5b6c218bd3eb7542fce92f3299e851 Mon Sep 17 00:00:00 2001
From: chantra <chantra@...1258...>
Date: Sat, 11 Dec 2010 18:27:23 +0100
Subject: [PATCH] Modified version of VLAN patch

From: Davide Guerri <dguerri <at> users.sourceforge.net>

This patch makes it possible to use the --passtos option with 802.1Q
tagged
ethernet frames.

sf.net tracker:
<https://sourceforge.net/tracker/?func=detail&aid=2829878&group_id=48978&atid=454721>

Signed-off-by: David Sommerseth <dazo <at> users.sourceforge.net>
Signed-off-by: chantra <chantra@...1258...>
---
 proto.c |   14 +++++++++++---
 proto.h |   12 ++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/proto.c b/proto.c
index 65a6b67..3cab61d 100644
--- a/proto.c
+++ b/proto.c
@@ -53,9 +53,17 @@ is_ipv4 (int tunnel_type, struct buffer *buf)
 	  + sizeof (struct openvpn_iphdr)))
 	return false;
       eh = (const struct openvpn_ethhdr *) BPTR (buf);
-      if (ntohs (eh->proto) != OPENVPN_ETH_P_IPV4)
-	return false;
-      offset = sizeof (struct openvpn_ethhdr);
+      if (ntohs (eh->proto) == OPENVPN_ETH_P_IPV4)
+        offset = sizeof (struct openvpn_ethhdr);
+      else if (ntohs (eh->proto) == OPENVPN_ETH_P_8021Q) {
+        const struct openvpn_8021qhdr *evh;
+        evh = (const struct openvpn_8021qhdr *) BPTR (buf);
+        if (ntohs (evh->proto) != OPENVPN_ETH_P_IPV4)
+          return false;
+        else
+          offset = sizeof (struct openvpn_8021qhdr);
+      } else
+        return false;
     }
   else
     return false;
diff --git a/proto.h b/proto.h
index 55f0832..66041b6 100644
--- a/proto.h
+++ b/proto.h
@@ -64,6 +64,18 @@ struct openvpn_ethhdr
   uint16_t proto;                     /* packet type ID field */
 };
 
+# define OPENVPN_ETH_P_8021Q  0x8100  /* 802.1Q protocol */
+
+struct openvpn_8021qhdr
+{
+  uint8_t dest[OPENVPN_ETH_ALEN];     /* destination ethernet addr */
+  uint8_t source[OPENVPN_ETH_ALEN];   /* source ethernet addr	*/
+
+  uint32_t tag;                       /* packet 802.1Q Vlan Tag */
+  uint16_t proto;                     /* packet type ID field */
+};
+
+
 struct openvpn_arp {
 # define ARP_MAC_ADDR_TYPE 0x0001
   uint16_t mac_addr_type;       /* 0x0001 */
-- 
1.7.1


--=-MhRxM79CiG3rg0Sc9171--



