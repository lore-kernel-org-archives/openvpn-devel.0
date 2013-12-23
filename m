Message-ID: <52B84C1F.8010500@...1847...>
Date: Mon, 23 Dec 2013 15:43:43 +0100
From: =?ISO-8859-1?Q?Andr=E9_Valentin?= <avalentin@...1847...>
MIME-Version: 1.0
References: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>
	<52B75C6B.9080100@...1847...> <52B76494.5010903@...1847...>
	<20131223113229.GB161@...1296...>
In-Reply-To: <20131223113229.GB161@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Floating: Add support for floating
 in TLS mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi!

On 23.12.2013 12:32, Gert Doering wrote:
> We've discussed the patch on the Munich Hackathon, and we intend to do
> it in a different way.  James wants to change the packet format for
> data packets anyway (due to bad alignment in the current packet format),
> and the new format would have the option to send the session ID in the
> data packet as well, like "normally it's not sent, but if we have't heard
> from the server longer than <x> time units, send a session ID so that
> hmac-float will work".
Of course, this is a better idea and should have less problems with scaling.
But there should be an option for the client to always send the session id,
so that there are no timeouts if the user decides to do so.

> This code has not been written yet, though, and we have no specific=20
> timelines when it will happen.
So what does this mean for my work and the current format? Is there still
a possibility that it will be integrated for the 'old packet format'?

Andr=E9

--
With kind regards,
Andr=E9 Valentin
Projektkoordination / Systemadministration

MarcanT GmbH, Ravensberger Str. 10 G, D - 33602 Bielefeld
Fon: +49 (521) 95945-0 | Fax -18
URL: http://www.marcant.net | http://www.global-m2m.com

Gesch=E4ftsf=FChrer: Thorsten Hojas
Handelsregister: AG Bielefeld, HRB 35827 USt-ID Nr.: DE 190203238

