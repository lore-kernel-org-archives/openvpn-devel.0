From: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: [Openvpn-devel] Protocol Change policy
Message-ID: <20020703103038.GB2057@...30...>
References: <03d501c221f7$26727830$1000000a@...4...> <1025687775.1385.63.camel@...2...>
Mime-Version: 1.0
In-Reply-To: <1025687775.1385.63.camel@...2...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Wed Jul  3 03:44:04 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, Jul 03, 2002 at 11:16:14AM +0200, Jan Johansson wrote:
> On Tue, 2002-07-02 at 20:34, James Yonan wrote: 
> > I'd like to hear your opinions on how the OpenVPN project should handle
> > patches which break backward compatibility.
> > Here are some answers that come to mind:
> > 
> > (1) Accumulate such patches and merge them all at once in a future release
> > such as 1.3.0 or 2.0.0, while warning users that this release will not be
> > backward compatible.
> 
> I'd prefer this one. Even though ssh seems to work nicely, you wind up 
> (at least when you have versions 1.3, 1.5 and 2) with lots of weird code
> that you can't figure out if it runs or not.
> 
> I'd like the more clean model without too much #ifdefs. With several
> platforms and stuff, you'll have enough of those anyhow. =)

I agree with Jan. Clean and simple. It works.
Warning users some versions before the change will reduce 'problems' a lot,
it's a good idea.

On the 'protocol version' subject, I think it could be a cool feature, 
specially if newer versions are backwards compatible. But IMHO it a hard
thing to develop and in case of being developed should wait until all
(today's) whished featured are implemented. I mean, (maybe) introducing
'protocol versions' too soon will end in too many versions, or waiting
for new features too much to avoid releasing new protocol versions.
(I don't know if I'm clear in this point, some times my English level 
seems not enough :-)

Regards,

Alberto


-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@...5...                     | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

