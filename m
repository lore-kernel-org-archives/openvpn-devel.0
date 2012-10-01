Message-ID: <506961AC.8090902@...1147...>
Date: Mon, 01 Oct 2012 11:26:04 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <12904-1349074708-498972@...1775...>
	<20121001083914.GS742@...1296...>
In-Reply-To: <20121001083914.GS742@...1296...>
Content-Type: multipart/alternative;
	boundary="------------020602010509020801060203"
Subject: Re: [Openvpn-devel] Ability to send variable data from client to
 server
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
--------------020602010509020801060203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gert,

Gert Doering wrote:
> Hi,
>
> On Mon, Oct 01, 2012 at 06:58:28AM +0000, f7n4ahbmp6@...1774... wrote:
>   
>> I believe there is ongoing development to allow a variable to be set in the client config which can be used by the client-connect or route-up scripts on the server. Specifically I need to add a custom route for each client depending on a value set in their config file. 
>>
>> Can anyone point me to a thread where this is being tracked or the person to whom this feature has been assigned as I would like to assist in development if possible.
>>     
>
> I'm not aware of such a development going on (doesn't mean nobody is 
> working on it, but it wasn't discussed recently on #openvpn-devel or this
> list)
>
> Can't you use the client's common-name or username for that?  That's what 
> everybody else seems to be doing...
>
>   
I'm the one who forwarded him to this mailing list; the "work" I'm 
referring to is the ENABLE_PUSH_PEER_INFO stuff which is present in 
openvpn 2.2+ but which does not seem to be complete. I was and am hoping 
that one of the developers (perhaps James Y?) can comment on the status.

cheers,

JJK


--------------020602010509020801060203
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Gert,<br>
<br>
Gert Doering wrote:
<blockquote cite="mid:20121001083914.GS742@...1296..." type="cite">
  <pre wrap="">Hi,

On Mon, Oct 01, 2012 at 06:58:28AM +0000, <a class="moz-txt-link-abbreviated" href="mailto:f7n4ahbmp6@...1774...">f7n4ahbmp6@...1774...</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I believe there is ongoing development to allow a variable to be set in the client config which can be used by the client-connect or route-up scripts on the server. Specifically I need to add a custom route for each client depending on a value set in their config file. 

Can anyone point me to a thread where this is being tracked or the person to whom this feature has been assigned as I would like to assist in development if possible.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'm not aware of such a development going on (doesn't mean nobody is 
working on it, but it wasn't discussed recently on #openvpn-devel or this
list)

Can't you use the client's common-name or username for that?  That's what 
everybody else seems to be doing...

  </pre>
</blockquote>
I'm the one who forwarded him to this mailing list; the "work" I'm
referring to is the ENABLE_PUSH_PEER_INFO stuff which is present in
openvpn 2.2+ but which does not seem to be complete. I was and am
hoping that one of the developers (perhaps James Y?) can comment on the
status.<br>
<br>
cheers,<br>
<br>
JJK<br>
<br>
</body>
</html>

--------------020602010509020801060203--

