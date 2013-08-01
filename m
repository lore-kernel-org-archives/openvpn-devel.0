Message-ID: <51FA79C6.1020405@...1147...>
Date: Thu, 01 Aug 2013 17:07:50 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <kt8j7m$c5m$1@...1062...> <20130730145731.GW13127@...1152...>
	<20130730151406.GQ16543@...1296...>
	<51FA324F.1090108@...1147...>
	<20130801143058.GM16543@...1296...>
In-Reply-To: <20130801143058.GM16543@...1296...>
Content-Type: multipart/alternative;
	boundary="------------020500050606020107090801"
Subject: Re: [Openvpn-devel] [Openvpn-users] why doesn't openvpn negotiate
	settings?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020500050606020107090801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gert,

Gert Doering wrote:
> Hi,
>
> On Thu, Aug 01, 2013 at 12:02:55PM +0200, Jan Just Keijser wrote:
>   
>> It should be possible to add negotiation without completely breaking 
>> backwards compatibility; right now, when a server pushes an option to 
>> the client that is unrecognized the client will print a warning but it 
>> will not abort. This could be used to push a 'negotation request' - if 
>> the client responds then a negotation phase can start , during which the 
>> encryption key, hashing cipher, MTU settings etc can be negotiated. If 
>> the client does not respond the server would need to assume that it's a 
>> 2.3 or older client.
>>     
>
> Maybe I'm a bit naive, but since the data layer cipher is independent of
> the TLS cipher anyway, can't we just "push cipher xxx"?
>
> Or is push/pull crypted with the data layer cipher?
>
>   
good question and one that I've asked myself as well -  there seems to 
be something funny going on with the data layer cipher (or auth parm) . 
I remember that I tried making the cipher and auth settings pushable and 
failed miserably. The flow of when and how the data cipher (and digest) 
are set up seems to be complicated and may happen (partially) *before* 
the options are pushed.
Perhaps someone else (JamesY?) can comment on this.

cheers,

JJK


--------------020500050606020107090801
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Gert,<br>
<br>
Gert Doering wrote:
<blockquote cite="mid:20130801143058.GM16543@...1296..." type="cite">
  <pre wrap="">Hi,

On Thu, Aug 01, 2013 at 12:02:55PM +0200, Jan Just Keijser wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">It should be possible to add negotiation without completely breaking 
backwards compatibility; right now, when a server pushes an option to 
the client that is unrecognized the client will print a warning but it 
will not abort. This could be used to push a 'negotation request' - if 
the client responds then a negotation phase can start , during which the 
encryption key, hashing cipher, MTU settings etc can be negotiated. If 
the client does not respond the server would need to assume that it's a 
2.3 or older client.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Maybe I'm a bit naive, but since the data layer cipher is independent of
the TLS cipher anyway, can't we just "push cipher xxx"?

Or is push/pull crypted with the data layer cipher?

  </pre>
</blockquote>
good question and one that I've asked myself as well -&nbsp; there seems to
be something funny going on with the data layer cipher (or auth parm) .
I remember that I tried making the cipher and auth settings pushable
and failed miserably. The flow of when and how the data cipher (and
digest) are set up seems to be complicated and may happen (partially)
*before* the options are pushed.<br>
Perhaps someone else (JamesY?) can comment on this.<br>
<br>
cheers,<br>
<br>
JJK<br>
<br>
</body>
</html>

--------------020500050606020107090801--

