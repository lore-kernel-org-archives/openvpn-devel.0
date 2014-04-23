Message-ID: <53579C5D.5000902@...1435...>
Date: Wed, 23 Apr 2014 12:56:29 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <53572C4E.7010701@...1901...> <20140423081058.GJ16637@...1296...>
In-Reply-To: <20140423081058.GJ16637@...1296...>
Subject: Re: [Openvpn-devel] Progress on Version negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 04/23/2014 10:10 AM, Gert Doering wrote:
> On Tue, Apr 22, 2014 at 10:58:22PM -0400, Timothe Litt wrote:
>> It does not appear to be the negotiation, rather it's TLS1.2.
> 
> This is quite cool, thank you.  (I'm not enough of a crypto geek to
> make real sense out of it, but it's quite useful to understand where
> it is failing, and I appreciate that you took the time to dig into it)
> 
> Steffan, Arne, any ideas?

This sounds very plausible, yes.

I've seen situations in which an OpenSSL 2.3.3 client refuses to connect
to a PolarSSL 1.2.10 server. I tried to reproduce that in a test setup
last night, but did not manage make it break. So I'm still a bit in the
dark on the real cause.

For the 'fix the breaking asap', maybe we should add an
--tls-version-max if that really resolves the problem.

-Steffan

