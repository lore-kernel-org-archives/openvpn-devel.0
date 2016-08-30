MIME-Version: 1.0
In-Reply-To: <17B2503A-3899-4E7C-B11D-4316B660CD2C@...2127...>
References: <57C482E0.6080308@...1147...>
	<20160829192838.GP78279@...1296...>
	<17B2503A-3899-4E7C-B11D-4316B660CD2C@...2127...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 30 Aug 2016 09:42:05 +0200
Message-ID: <CAA1AbxKC4yjzSP79G=PQ+sgbHW+axySxnyyLfuJc+NFq1D4CXw@...278...>
Subject: Re: [Openvpn-devel] Time to change the default cipher?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 30 August 2016 at 09:01, Jens Neuhalfen <openvpn-devel@...2127...> wrote:
>> OTOH, what we could do is: indeed *change+ the default, and add a big fat
>> warning ("you have not specified a --cipher directive.  The default has
>> been changed from 2.3 to 2.4, so please ensure your config matches the
>> other end" or something like that)
>
> This seems like a good idea, maybe like so?
>
> - A =E2=80=9Cdefault will change=E2=80=9D warning on =E2=80=9C2.3=E2=80=
=9D when no chipher is selected
> - AES-256-GCM as new default for 2.4

Even though I'm in favour of changing the default cipher, I'm afraid
this will break too many setups, causing users to give up on OpenVPN.
Cipher negotiation basically updates the default to AES-256-GCM, but
will not break connections with older clients.  Whether we should also
change the default cipher is something I'll let the OpenVPN 'veterans'
decide.

> - When used, a =E2=80=9CYou are using 64 bit block ciphers and this is a =
bad idea=E2=80=9D message on 2.3 and 2.4

This we already have in place in both 2.3(.12) and 2.4, see
http://www.mail-archive.com/openvpn-devel%40lists.sourceforge.net/msg00030.=
html.

-Steffan

