Message-ID: <51FA324F.1090108@...1147...>
Date: Thu, 01 Aug 2013 12:02:55 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <kt8j7m$c5m$1@...1062...> <20130730145731.GW13127@...1152...>
	<20130730151406.GQ16543@...1296...>
In-Reply-To: <20130730151406.GQ16543@...1296...>
Content-Type: multipart/alternative;
	boundary="------------090104090507050608010903"
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
--------------090104090507050608010903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gert Doering wrote:
> Hi,
>
> On Tue, Jul 30, 2013 at 04:57:31PM +0200, Ralf Hildebrandt wrote:
>   
>> I was wondering about this as well. This makes it extremely hard to
>> every change the cipher (i.e. if it's not considered "safe" anymore)
>>     
>
> It needs to be implemented, tested, etc. - and I'm not sure right now
> whether it can be done at all without changing the openvpn protocol in
> an incompatible way.  It might work, it might not.
>
> JJK might know more whether it can be done at all...
>
>   
I'm CC'ing in the openvpn-devel list as I hope that some on that list 
can comment :)

It should be possible to add negotiation without completely breaking 
backwards compatibility; right now, when a server pushes an option to 
the client that is unrecognized the client will print a warning but it 
will not abort. This could be used to push a 'negotation request' - if 
the client responds then a negotation phase can start , during which the 
encryption key, hashing cipher, MTU settings etc can be negotiated. If 
the client does not respond the server would need to assume that it's a 
2.3 or older client.

This is quite an extensive change however, especially as the client 
needs to send back information (similar to the PUSH_PEER_INFO stuff).

If someone knows of a better way to add a negotiation phase (esp BEFORE 
the push/pull phase has started) without breaking older clients then I'd 
be happy to hear about it.

cheers,

JJK



--------------090104090507050608010903
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Gert Doering wrote:
<blockquote cite="mid:20130730151406.GQ16543@...1296..." type="cite">
  <pre wrap="">Hi,

On Tue, Jul 30, 2013 at 04:57:31PM +0200, Ralf Hildebrandt wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I was wondering about this as well. This makes it extremely hard to
every change the cipher (i.e. if it's not considered "safe" anymore)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It needs to be implemented, tested, etc. - and I'm not sure right now
whether it can be done at all without changing the openvpn protocol in
an incompatible way.  It might work, it might not.

JJK might know more whether it can be done at all...

  </pre>
</blockquote>
I'm CC'ing in the openvpn-devel list as I hope that some on that list
can comment :)<br>
<br>
It should be possible to add negotiation without completely breaking
backwards compatibility; right now, when a server pushes an option to
the client that is unrecognized the client will print a warning but it
will not abort. This could be used to push a 'negotation request' - if
the client responds then a negotation phase can start , during which
the encryption key, hashing cipher, MTU settings etc can be negotiated.
If the client does not respond the server would need to assume that
it's a 2.3 or older client.<br>
<br>
This is quite an extensive change however, especially as the client
needs to send back information (similar to the PUSH_PEER_INFO stuff). <br>
<br>
If someone knows of a better way to add a negotiation phase (esp BEFORE
the push/pull phase has started) without breaking older clients then
I'd be happy to hear about it.<br>
<br>
cheers,<br>
<br>
JJK<br>
<br>
<br>
</body>
</html>

--------------090104090507050608010903--

