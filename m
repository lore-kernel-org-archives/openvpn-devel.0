From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 8 Apr 2014 16:13:59 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B90170093CEF0@...1436...>
References: <5343BCAB.3040102@...1790...> <0LikyX-1X9YfO48dR-00d2sy@...1825...>
	<1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>
	<5343E392.1010803@...1800...>
	<1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>
	<534401D6.1080604@...1800...>
In-Reply-To: <534401D6.1080604@...1800...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Heartbleed
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
To: Mike Tancsa <mike@...1800...>, Adriaan de Jong <dejong@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 08/04/2014 16:04, Mike Tancsa wrote:
> How does one attack the client ? In my case, the client only connects
> to my servers ? I use a tls-auth key file as well. If I understand
> correctly, the scenario would be the attacker would have to have the
> tls-auth key file, and then do a man in the middle attack to pretend
> its the server's IP, and then coax the client into allocating the 64k
> block of memory as described in the above link ?

Correct. But man-in-the-middle can also be something like DNS poisoning.

If you use TLS-auth, the attacker must have previously obtained the TLS-aut=
h key. When the user base is large, it is not unlikely that one of the user=
s was compromised and should be considered malicious.

-Steffan

