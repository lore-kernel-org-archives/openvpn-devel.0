Message-ID: <53525655.4010301@...1147...>
Date: Sat, 19 Apr 2014 12:56:21 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
	<20140418210522.GE16637@...1296...>
In-Reply-To: <20140418210522.GE16637@...1296...>
Content-Type: multipart/alternative;
	boundary="------------020901010400070808050105"
Subject: Re: [Openvpn-devel] Fixes for HTTP proxy authentication with NTLM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020901010400070808050105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 18/04/14 23:05, Gert Doering wrote:
> Hi,
>
> On Wed, Apr 16, 2014 at 12:48:35PM +0200, Holger Kummert wrote:
>> Any opinions?
> Any easy way to test this, without having a Windows domain around?
>
> (I already run a number of test cases from my t_client test sets using
> socks proxy, http proxy, http proxy to ipv4 hosts over ipv6, ..., and
> if I could "easily" add a proxy with NTML auth to that mix, it would help
> ensure that we're not accidentially breaking things)
actually: no ; when the original NTML problems were reported I tried to 
reproduce them in my Windows Domain less environment and couldn't ; the 
existing code was working quite nicely; even setting up a Samba domain 
did not help - that also worked, IIRC. For proper testing you'd have to 
have a Windows domain, and even worse, different version of the Domain 
Controller as well (Win2003, 2007, 2012 etc).


JM2CW,

JJK
> gert
>
>


--------------020901010400070808050105
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi,<br>
      <br>
      On 18/04/14 23:05, Gert Doering wrote:<br>
    </div>
    <blockquote cite="mid:20140418210522.GE16637@...1296..."
      type="cite">
      <pre wrap="">Hi,

On Wed, Apr 16, 2014 at 12:48:35PM +0200, Holger Kummert wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Any opinions?
</pre>
      </blockquote>
      <pre wrap="">
Any easy way to test this, without having a Windows domain around?

(I already run a number of test cases from my t_client test sets using
socks proxy, http proxy, http proxy to ipv4 hosts over ipv6, ..., and
if I could "easily" add a proxy with NTML auth to that mix, it would help 
ensure that we're not accidentially breaking things)
</pre>
    </blockquote>
    actually: no ; when the original NTML problems were reported I tried
    to reproduce them in my Windows Domain less environment and couldn't
    ; the existing code was working quite nicely; even setting up a
    Samba domain did not help - that also worked, IIRC. For proper
    testing you'd have to have a Windows domain, and even worse,
    different version of the Domain Controller as well (Win2003, 2007,
    2012 etc).<br>
    <br>
    <br>
    JM2CW,<br>
    <br>
    JJK<br>
    <blockquote cite="mid:20140418210522.GE16637@...1296..."
      type="cite">
      <pre wrap="">
gert
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------020901010400070808050105--

