Message-ID: <4EA52D4D.70409@...1435...>
Date: Mon, 24 Oct 2011 11:18:05 +0200
From: Adriaan de Jong <dejong@...1435...>
MIME-Version: 1.0
References: <1319445962-21686-1-git-send-email-dejong@...1435...>
	<1319445962-21686-3-git-send-email-dejong@...1435...>
	<4EA52800.4080205@...1147...>
	<1CED409804E2164C8104F9E623B08B90127CB75804@...1436...>
	<4EA529C7.1090202@...1147...>
In-Reply-To: <4EA529C7.1090202@...1147...>
Content-Type: multipart/alternative;
	boundary="------------000709060200090207080002"
Subject: Re: [Openvpn-devel] [PATCH 3/3] Changed default algorithm for
 PolarSSL to AES-128, as BF is not supported
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--------------000709060200090207080002
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/2011 11:03 AM, Jan Just Keijser wrote:
> Adriaan de Jong wrote:
>> Unfortunately BF isn't supported in PolarSSL though.
>>
>> Do you have any other suggestions? I'm open to most ideas other than "implement blowfish" :)
>>    
> hmmm then perhaps the default should be changed to AES-128 ?
>
That's an interesting option, but changing that default might cause even 
more pain :)

> I foresee a lot of openvpn-users mails and forums hits from people 
> saying stuff like 'I am running opevpn 2.1 on the server using default 
> settings and am connecting using openvpn 2.3/polarssl and bla bla' : 
> we need to think  about how we want to tackle issues like that (is 
> there a way to determine at runtime which version of which SSL 
> implementation is used? OpenSSL has such a (runtime!) call.
You can see the local SSL implementation in the header, but not the 
remote one (at the moment).

> The ideal solution would be to set a 'crypto negotiation phase' during 
> which the client and server negotiate about the available crypto 
> routines, pretty much like the "standard" TLS/SSL protocol does (and 
> which is done on the OpenVPN control channel, but not on the data 
> channel).
That might be a good idea, as long as there are good filter options to 
enforce policy. It would probably require a protocol change though.

Adriaan

--------------000709060200090207080002
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 10/24/2011 11:03 AM, Jan Just Keijser wrote:
    <blockquote cite="mid:4EA529C7.1090202@...1147..." type="cite">
      <meta content="text/html; charset=ISO-8859-1"
        http-equiv="Content-Type">
      Adriaan de Jong wrote:
      <blockquote
        cite="mid:1CED409804E2164C8104F9E623B08B90127CB75804@...1436..."
        type="cite">
        <pre wrap="">Unfortunately BF isn't supported in PolarSSL though. 

Do you have any other suggestions? I'm open to most ideas other than "implement blowfish" :)
  </pre>
      </blockquote>
      hmmm then perhaps the default should be changed to AES-128 ?<br>
      <br>
    </blockquote>
    That's an interesting option, but changing that default might cause
    even more pain :)<br>
    <br>
    <blockquote cite="mid:4EA529C7.1090202@...1147..." type="cite">
      I foresee a lot of openvpn-users mails and forums hits from people
      saying stuff like 'I am running opevpn 2.1 on the server using
      default
      settings and am connecting using openvpn 2.3/polarssl and bla bla'
      : we
      need to think&nbsp; about how we want to tackle issues like that (is
      there a
      way to determine at runtime which version of which SSL
      implementation
      is used? OpenSSL has such a (runtime!) call. <br>
    </blockquote>
    You can see the local SSL implementation in the header, but not the
    remote one (at the moment).<br>
    <br>
    <blockquote cite="mid:4EA529C7.1090202@...1147..." type="cite">
      The ideal solution would be to set a 'crypto negotiation phase'
      during
      which the client and server negotiate about the available crypto
      routines, pretty much like the "standard" TLS/SSL protocol does
      (and
      which is done on the OpenVPN control channel, but not on the data
      channel).<br>
    </blockquote>
    That might be a good idea, as long as there are good filter options
    to enforce policy. It would probably require a protocol change
    though.<br>
    <br>
    Adriaan<br>
  </body>
</html>

--------------000709060200090207080002--

