From: chantra <chantra@...1258...>
In-Reply-To: <mailman.487721.1275403360.5170.openvpn-devel@lists.sourceforge.net>
References: <mailman.487721.1275403360.5170.openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-hjxWs51601BZY9ieojxl"
Date: Thu, 03 Jun 2010 16:48:35 +0200
Message-ID: <1275576515.23148.829.camel@...1259...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Re: Handling of subnets grammar in Packet
	filter file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-hjxWs51601BZY9ieojxl
Content-Type: multipart/alternative; boundary="=-KMFIWZ3posF4JR1G1e4A"

--=-KMFIWZ3posF4JR1G1e4A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Please find below a patch to correct the behaviour.

I have also opened a trac ticket :
https://community.openvpn.net/openvpn/ticket/14

chantra

----
http://www.debuntu.org


> 
> Hi all,
> 
> It seems that openvpn is not handling properly non-standard subnets in
> pf_file.
> This issue happened on debian etch openvpn 2.1 rc11
> 
> Today, while I made a typo, the following rule did not work properly:
> 
>         # cat /dev/shm/openvpn_pf_73f2c3256a50371f057d5c0db97ede2f.tmp
>         [CLIENTS DROP]
>         
>         [SUBNETS ACCEPT]
>         +192.168.100.0/29
>         -192.168.100.8/28
>         
>         [END]
>         
> 
> -192.168.100.8/28 was simply ignored which basically allowed the client
> to ping the whole subnet
> 
> The following rule behaved properly though.
> 
>         # cat /dev/shm/openvpn_pf_f2b43d3cb1acd5a2720c01559cb03dc3.tmp
>         [CLIENTS DROP]
>         
>         [SUBNETS ACCEPT]
>         +192.168.100.0/29
>         -192.168.100.0/28
>         [END]
>         
> 
> I agree it is not a really bug as it is a user error in the first place
> and openvpn carried on happily discarding this rule.
> But maybe openvpn could try to handle such subnets and translate it as
> 192.168.100.0/8.
> 
> I could try to look into it if you guys believe it should be handled by
> openvpn (or maybe this has already been fixed?)
> 
> Regards,
> 
> chantra
> 




!DSPAM:4c07c0c661671935912581!

--=-KMFIWZ3posF4JR1G1e4A
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.28.3">
</HEAD>
<BODY>
Please find below a patch to correct the behaviour.<BR>
<BR>
I have also opened a trac ticket : <A HREF="https://community.openvpn.net/openvpn/ticket/14">https://community.openvpn.net/openvpn/ticket/14</A><BR>
<BR>
chantra<BR>
<BR>
----<BR>
<A HREF="http://www.debuntu.org">http://www.debuntu.org</A><BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>

Hi all,

It seems that openvpn is not handling properly non-standard subnets in
pf_file.
This issue happened on debian etch openvpn 2.1 rc11

Today, while I made a typo, the following rule did not work properly:

        # cat /dev/shm/openvpn_pf_73f2c3256a50371f057d5c0db97ede2f.tmp
        [CLIENTS DROP]
        
        [SUBNETS ACCEPT]
        +192.168.100.0/29
        -192.168.100.8/28
        
        [END]
        

-192.168.100.8/28 was simply ignored which basically allowed the client
to ping the whole subnet

The following rule behaved properly though.

        # cat /dev/shm/openvpn_pf_f2b43d3cb1acd5a2720c01559cb03dc3.tmp
        [CLIENTS DROP]
        
        [SUBNETS ACCEPT]
        +192.168.100.0/29
        -192.168.100.0/28
        [END]
        

I agree it is not a really bug as it is a user error in the first place
and openvpn carried on happily discarding this rule.
But maybe openvpn could try to handle such subnets and translate it as
192.168.100.0/8.

I could try to look into it if you guys believe it should be handled by
openvpn (or maybe this has already been fixed?)

Regards,

chantra

</PRE>
</BLOCKQUOTE>
<BR>

!DSPAM:4c07c0c661671935912581!

</BODY>
</HTML>



--=-KMFIWZ3posF4JR1G1e4A--

--=-hjxWs51601BZY9ieojxl
Content-Disposition: attachment;
	filename="0001-Handle-non-standard-subnets-in-PF-grammar.patch"
Content-Type: text/x-patch;
	name="0001-Handle-non-standard-subnets-in-PF-grammar.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 09ddcf75171804503119912b45876d92c3476cbc Mon Sep 17 00:00:00 2001
From: chantra <chantra@...1258...>
Date: Wed, 2 Jun 2010 12:44:26 +0200
Subject: [PATCH] Handle non standard subnets in PF grammar

Allow subnets for like 192.168.100.8/28 to be understood
---
 pf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pf.c b/pf.c
index 3ce2ef2..f16ec9c 100644
--- a/pf.c
+++ b/pf.c
@@ -121,7 +121,7 @@ add_subnet (const char *line, const char *prefix, const int line_num, struct pf_
     struct pf_subnet *e;
     ALLOC_OBJ_CLEAR (e, struct pf_subnet);
     e->rule.exclude = exclude;
-    e->rule.network = ntohl (network.s_addr);
+    e->rule.network = ntohl (network.s_addr) & netmask;
     e->rule.netmask = netmask;
     **next = e;
     *next = &e->next;
-- 
1.5.6.5


--=-hjxWs51601BZY9ieojxl--



