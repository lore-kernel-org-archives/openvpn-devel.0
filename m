Message-ID: <0BD23D4B562943FD8C84B960FD3F4FA3@...2089...>
From: <debbie10t@...277...>
References: <6A88A2ADF6B64829BF9DA9EAA97BF3B0@...2089...>
	<9C407472-153C-40F9-ACE4-0A1045B23F19@...1127...>
Date: Wed, 3 Feb 2016 01:44:10 -0000
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Just a thought - config hashing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="utf-8"; reply-type=original
Content-Transfer-Encoding: 7bit
To: David Sommerseth <david@...1127...>, openvpn-devel@lists.sourceforge.net

Hi David,

thankyou for your detailed reply ..I looked up eurephia :-) nice
and did a little more research and discovered anonyproz.com
The idea has some merit but it is not for the core openvpn team.
I see that now .. I am, as ever, still learning and, on this occasion,
maybe seeing things a little more clearly ..
Ironically, this maybe one idea where open vs closed source
"shows it's teeth" a little. C'est la vie and thanks for your time ..
mvh :D


----- Original Message ----- 
From: "David Sommerseth" <david@...1127...>
To: <debbie10t@...277...>; <openvpn-devel@lists.sourceforge.net>
Sent: Tuesday, February 02, 2016 5:20 PM
Subject: Re: [Openvpn-devel] Just a thought - config hashing


On 2 February 2016 00:01:58 CET, debbie10t@...277... wrote:
>Hi
>
>I sat in on the meeting today 2016-02-01 as manhaton
>
>Watching the discussion about elevated privileges regarding
>a non-admin user interacting with the iservice, a subject to which
>I am ignorant with regard to programming ..
>
>Anyway, an idea struck me ...
>
>It is a *little* off-piste so .. new thread.
>
>Why not .. (pleaze shoot me down if this is stupid)
>
>OpenVPN could HASH the *current* config file on the fly:


I had a similar "bright" idea a few years ago too.  And it was shut down
quite quickly back then too, with very good reasons.  Because I hadn't
really thought this through properly.

Basically, you cannot trust the client at all.  Bottom line is that the
server needs to verify whatever the client does, but you can never trust the
client to provide the information the server asks for *and* at the same time
be sure the client didn't modify what it sent to the server first.  In fact,
the client can send whatever it believes the server expects and do something
completely different locally - because the server can not validate what is
really happening on the client side.  This is open source software, so you
cannot be 100% sure the client runs exactly a particular version of OpenVPN.
What the client tells the server cannot be verified in any way.

I honestly believe OpenConnect is into something better.  You just provide a
server URL and the server pushes the config to the client on-the-fly.  But
again, even here the client can do what it wants with that data.

Another way "around" this is that you push a binary blob which the client
needs to execute ... but don't get me started on the security issues related
to this.  Plus the nightmare of supporting different CPU architectures,
different glibc, openssl/polarssl/mbdtls libraries, etc, etc .... So that's
also never gonna fly.

The only to be sure the client does what it is supposed to, is to controll
the VPN network traffic it tries to push over the tunnel to the server,
which means firewall rules.  This is one (of several) reasons I started the
eurephia project ages ago, which still runs very well on latest openvpn
2.3.10 servers.


-- 
mvh.

David Sommerseth


