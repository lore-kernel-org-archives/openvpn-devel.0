Message-ID: <4DC94132.1040302@...1147...>
Date: Tue, 10 May 2011 15:44:18 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4DC936F3.6000509@...1458...> <4DC93E4C.5070606@...1147...>
	<20110510133830.GD8496@...1296...>
In-Reply-To: <20110510133830.GD8496@...1296...>
Content-Type: multipart/alternative;
	boundary="------------010805000109050506060209"
Subject: Re: [Openvpn-devel] Fwd: OpenVPN netsh.exe patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010805000109050506060209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Gert Doering wrote:
> Hi,
>
> On Tue, May 10, 2011 at 03:31:56PM +0200, Jan Just Keijser wrote:
>   
>> Seth Mos wrote:
>>     
>>> Here is the tun.c patch for correction of the netsh.exe commands.
>>>
>>> I've confirmed that the patch works on Windows XP SP2 and Windows 7.
>>>
>>> Patch!
>>> http://iserv.nl/files/pfsense/0001-Change-the-netsh.exe-command-from-add-to-set-.-Th.patch
>>>       
>> please explain the rationale behind this patch: is something wrong when
>> using 'ipv6 add address' ? 
>>     
>
> Without "store=active", address assignment is "sticky" and will even
> survive reboots - thus making the next tunnel setup fail, because the
> address is already there.  On WinXP, that was not needed, but Win7 seems
> to have changed the default.
>
>   
but then why not use
  add address <> store=active
? why switch to "set address" ? what's the difference?

JJK


--------------010805000109050506060209
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
Gert Doering wrote:
<blockquote cite="mid:20110510133830.GD8496@...1296..." type="cite">
  <pre wrap="">Hi,

On Tue, May 10, 2011 at 03:31:56PM +0200, Jan Just Keijser wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Seth Mos wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Here is the tun.c patch for correction of the netsh.exe commands.

I've confirmed that the patch works on Windows XP SP2 and Windows 7.

Patch!
<a class="moz-txt-link-freetext" href="http://iserv.nl/files/pfsense/0001-Change-the-netsh.exe-command-from-add-to-set-.-Th.patch">http://iserv.nl/files/pfsense/0001-Change-the-netsh.exe-command-from-add-to-set-.-Th.patch</a>
      </pre>
    </blockquote>
    <pre wrap="">please explain the rationale behind this patch: is something wrong when
using 'ipv6 add address' ? 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Without "store=active", address assignment is "sticky" and will even
survive reboots - thus making the next tunnel setup fail, because the
address is already there.  On WinXP, that was not needed, but Win7 seems
to have changed the default.

  </pre>
</blockquote>
but then why not use<br>
&nbsp; add address &lt;&gt; store=active<br>
? why switch to "set address" ? what's the difference?<br>
<br>
JJK<br>
<br>
</body>
</html>

--------------010805000109050506060209--

