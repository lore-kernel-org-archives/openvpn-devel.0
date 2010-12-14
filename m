From: chantra <chantra@...1258...>
In-Reply-To: <AANLkTi=Fykb-NkSxx+=HM1U0ob4mmD0GkyfP_Mhb9=m1@...278...>
References: <AANLkTi=Fykb-NkSxx+=HM1U0ob4mmD0GkyfP_Mhb9=m1@...278...>
Content-Type: multipart/alternative; boundary="=-xlusPLEv6WQj/Cc5dbnH"
Date: Tue, 14 Dec 2010 01:35:24 +0100
Message-ID: <1292286924.6222.3.camel@...1259...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] Can *plugin* kill specific ovpn tunnel?...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vineet Kumar <vineet.kumar@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--=-xlusPLEv6WQj/Cc5dbnH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Vineet,

I think you could use Packet filtering plugin hook and use the [KILL]
tag at the end of the pf file .

See
http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=openvpn-plugin.h;h=56b0a701574e6913b3a714e941cdc4899dbea8e1;hb=HEAD#l316

I have never used it myself, but I think that should sort you out.

The doc says that this file may be dynamically updated during a client
session. I assume the main process will pick up the change quick fast.

Chantra

On Mon, 2010-12-13 at 15:16 -0800, Vineet Kumar wrote:

> Hi,
>   If my openvpn plugin spawns its own thread and from that thread
> wants to kill a tunnel specified by IP:port how can that be done?
> (something like what the 'telnet' management provides: "kill IP:port")
> This plugin is meant to do other stuff and in certain scenarios wants
> to close specific tunnels.
> First I thought of using the plugin to write code to establish a
> telnet-client sessions and send over "kill IP:port" command. But I
> notice an issue with the management listener: if I run more than 1
> telnet session only the first one can pass through data whereas all
> others' telnet sessions just hang.
> 
> Is this even possible?
> 
> Vineet
> 
> ------------------------------------------------------------------------------
> Lotusphere 2011
> Register now for Lotusphere 2011 and learn how
> to connect the dots, take your collaborative environment
> to the next level, and enter the era of Social Business.
> http://p.sf.net/sfu/lotusphere-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


-- 
http://www.debuntu.org

--=-xlusPLEv6WQj/Cc5dbnH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.30.3">
</HEAD>
<BODY>
Vineet,<BR>
<BR>
I think you could use Packet filtering plugin hook and use the [KILL] tag at the end of the pf file .<BR>
<BR>
See <A HREF="http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=openvpn-plugin.h;h=56b0a701574e6913b3a714e941cdc4899dbea8e1;hb=HEAD#l316">http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=openvpn-plugin.h;h=56b0a701574e6913b3a714e941cdc4899dbea8e1;hb=HEAD#l316</A><BR>
<BR>
I have never used it myself, but I think that should sort you out.<BR>
<BR>
The doc says that this file may be dynamically updated during a client session. I assume the main process will pick up the change quick fast.<BR>
<BR>
Chantra<BR>
<BR>
On Mon, 2010-12-13 at 15:16 -0800, Vineet Kumar wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
Hi,
  If my openvpn plugin spawns its own thread and from that thread
wants to kill a tunnel specified by IP:port how can that be done?
(something like what the 'telnet' management provides: &quot;kill IP:port&quot;)
This plugin is meant to do other stuff and in certain scenarios wants
to close specific tunnels.
First I thought of using the plugin to write code to establish a
telnet-client sessions and send over &quot;kill IP:port&quot; command. But I
notice an issue with the management listener: if I run more than 1
telnet session only the first one can pass through data whereas all
others' telnet sessions just hang.

Is this even possible?

Vineet

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
<A HREF="http://p.sf.net/sfu/lotusphere-d2d">http://p.sf.net/sfu/lotusphere-d2d</A>
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

--=-xlusPLEv6WQj/Cc5dbnH--



