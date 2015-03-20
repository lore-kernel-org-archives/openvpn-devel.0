From: Ryan O'Connor <ryanoconnor@...2020...>
Date: Fri, 20 Mar 2015 07:59:34 +0000
Message-ID: <AM3PR07MB2250C04AEA819AB8748A362C10E0@...2023...>
References: <AMSPR07MB232F26EA163FA5FB6ACEA0EC1010@...2021...>
	<550AD5A3.9040201@...515...> <550B4623.6000609@...1490...>
In-Reply-To: <550B4623.6000609@...1490...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN Service Windows 8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Jason Haar <Jason_Haar@...1490...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hmm Interesting idea.

I will grab a copy of NSSM and give it a try.

So does it need to be constantly running on the client machine or is it jus=
t a service installer that you setup the service and its parameters (im gue=
ssing what .ovpn connection to run) and it will install it?

Thanks for the recommendation!

Ryan

-----Original Message-----
From: Jason Haar [mailto:Jason_Haar@...1490...]=20
Sent: 19 March 2015 21:57
To: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] OpenVPN Service Windows 8

Unless other changes have been made to the windows service, I'd recommend n=
ot using it at all. There are error conditions under which it just hangs an=
d blocks openvpn.exe from working

We moved to using nssm - we set it to auto-restart on error and now openvpn=
 as a Windows service is as reliable as openvpn as a Unix service

Jason

--
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


---------------------------------------------------------------------------=
---
Dive into the World of Parallel Programming The Go Parallel Website, sponso=
red by Intel and developed in partnership with Slashdot Media, is your hub =
for all things parallel software development, from weekly thought leadershi=
p blogs to news, videos, case studies, tutorials and more. Take a look and =
join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

