Message-ID: <54874E0F.2070400@...1490...>
Date: Wed, 10 Dec 2014 08:31:27 +1300
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
References: <54833CC6.8010507@...1490...> <5486B561.8080104@...515...>
	<20141209190918.GA17158@...1296...>
In-Reply-To: <20141209190918.GA17158@...1296...>
Subject: Re: [Openvpn-devel] feature request: get openvpn to use closest
	server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, =?windows-1252?Q?Samuli_Sepp=E4?= =?windows-1252?Q?nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

On 10/12/14 08:09, Gert Doering wrote:
> In what kind of scenario would an OpenVPN server not be available, if
> the server itself still responds to pings?
> "The server process crashed".

LOL! It took Gert to spot the most obvious scenario ;-) That really
re-enforces what I think about this needing to be an "openvpn ping" type
solution: it is irrelevant if the server is up or even if openvpn tcp
ports appear to be open, it's only evidence that openvpn is working that
should be taken as evidence that openvpn is - well - working :-)


--=20
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1



