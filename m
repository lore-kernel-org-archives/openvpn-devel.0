Date: Mon, 14 Apr 2014 11:00:37 +0200 (CEST)
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <823633918.13589.1397466037908.JavaMail.zimbra@...1795...>
In-Reply-To: <20140413152613.GT16637@...1296...>
References: <20140413152613.GT16637@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


----- Opprinnelig melding -----
> Fra: "Gert Doering" <gert@...1296...>
> Til: openvpn-devel@lists.sourceforge.net
> Sendt: 13. april 2014 17:26:13
> Emne: [Openvpn-devel] RFD: ssl library version numbers
> 
> Hi,
> 
> OpenVPN does not currently report the version of the SSL library it is
> using - which I'm not sure whether it's by design or just because nobody
> ever added it.  Anyway, right now I think we need it, to help future
> cases.
> 
> There are a few questions that go along with that, which I want to discuss
> here :-)
> 
> - shall we report compile-time versions as well, or only run-time version?

I'd say we should return *run-time* versions.  For RPM based distros at
least, the OpenSSL library can be upgraded without a rebuild of OpenVPN
(as long as the ABI doesn't change, which most enterprise level distros
will beware of).  In that perspective there is not much value which
compile-time version OpenVPN was compiled against.

The only time OpenSSL compile-time versions is interesting is when there
are #define constants and macros which would directly change the OpenVPN
runtime behaviour.  But such changes is actually breaking the OpenSSL ABI,
which again most enterprise level distros will beware of and avoid.  And
I even believe, at least for OpenSSL, that such ABI breaking changes goes
into their major releases, not the minor updates.


--
kind regards,

David Sommerseth

