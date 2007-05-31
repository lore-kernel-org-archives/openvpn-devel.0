Message-ID: <2658da010705310740s3a13b7a0kbfd4936bfea2a8a3@...278...>
Date: Thu, 31 May 2007 16:40:21 +0200
From: "Jeremy Garrouste" <jeremy.garrouste@...277...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_25230_29100236.1180622421411"
Subject: [Openvpn-devel] connect-retry and UDP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_Part_25230_29100236.1180622421411
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have a problem with my client configuration of OpenVPN. I use it in UDP
mode and i can't set the variable "connect-retry" because as upd is a non
connected protocol. Aniway I'd like to change time between each connection
retry.

option.c :
/*
 * Sanity check on TCP mode options
 */
  if (options->connect_retry_defined && options->proto !=
PROTO_TCPv4_CLIENT)
    msg (M_USAGE, "--connect-retry doesn't make sense unless also used with
--proto tcp-client");

-- 
Jeremy GARROUSTE

------=_Part_25230_29100236.1180622421411
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I have a problem with my client configuration of OpenVPN.
I use it in UDP mode and i can&#39;t set the variable &quot;connect-retry&quot; because
as upd is a non connected protocol. Aniway I&#39;d like to change time
between each connection retry.
<span class="q"><br><br>option.c :<br><span style="font-style: italic;"> /*</span><br style="font-style: italic;"><span style="font-style: italic;">&nbsp;* Sanity check on TCP mode options</span><br style="font-style: italic;">
<span style="font-style: italic;">

&nbsp;*/</span><br style="font-style: italic;"><span style="font-style: italic;">&nbsp; if (options-&gt;connect_retry_defined &amp;&amp; options-&gt;proto != PROTO_TCPv4_CLIENT)</span><br style="font-style: italic;"><span style="font-style: italic;">


&nbsp;&nbsp;&nbsp; msg (M_USAGE, &quot;--connect-retry doesn&#39;t make sense unless also used with --proto tcp-client&quot;);</span></span><br clear="all"><br>-- <br>Jeremy GARROUSTE

------=_Part_25230_29100236.1180622421411--

