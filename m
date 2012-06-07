From: Frank de Brabander <brabander@...1435...>
Date: Thu, 7 Jun 2012 11:35:58 +0200
Message-ID: <CBF6422A.24DA%brabander@...1435...>
In-Reply-To: <4FD0735C.7090902@...515...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] PolarSSL 1.1.0 support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Maybe this should actually be changed to >=3D 1.1.2, since there is a
security issue with versions from 0.99-pre4 up to and including PolarSSL
1.1.1.

On 07-06-12 11:24, "Samuli Sepp=E4nen" <samuli@...515...> wrote:

>Hi,
>
>I noticed that my Ubuntu 10.04 and 12.04 buildslaves which had PolarSSL
>1.1.0 failed build during the configure phase:
>
>checking polarssl version... configure: error: invalid polarssl version
>
>Updating to PolarSSL 1.1.1 or later solves this issue. However, commit
>1d92d06dca5ac says "Removed support for PolarSSL < 1.1", so 1.1.0 should
>work, right?
>
>--=20
>Samuli Sepp=E4nen
>Community Manager
>OpenVPN Technologies, Inc
>
>irc freenode net: mattock
>
>
>
>
>
>--------------------------------------------------------------------------
>----
>Live Security Virtual Conference
>Exclusive live event will cover all the ways today's security and
>threat landscape has changed and how IT managers can respond. Discussions
>will include endpoint security, mobile security and the latest in malware
>threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>_______________________________________________
>Openvpn-devel mailing list
>Openvpn-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/openvpn-devel


