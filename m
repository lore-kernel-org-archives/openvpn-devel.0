From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvsjwyxjcq.fsf-monnier+INBOX@...1269...>
References: <4D2C3D0A.2060607@...1114...> <4D2D68E0.9080702@...68...>
Date: Wed, 12 Jan 2011 09:56:25 -0500
In-Reply-To: <4D2D68E0.9080702@...68...> (Matthias Andree's message of "Wed, 12
	Jan 2011 09:40:00 +0100")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN documentation (man page) review
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

>> * Move the man page to a better format than the pure man page format.
>> Are there some good tools/formats like ascii2man or DocBookXML which
>> could help easing the maintenance of our documentation?

> Docbook XML for sure is a lot more verbose than asciidoc or roff.
> I would tend to avoid Docbook, the toolchains are lacking a bit --
> still :-( although xmlto + fop can yield reasonable PDF results.

I'd recommend Texinfo: its man output is not too bad (especially if you
write the Texinfo with "man" in your mind), it can be turned into
many other formats (including Docbook) and it's not verbose.


        Stefan

