Date: Fri, 13 Nov 2009 15:28:36 +0300
From: Victor Wagner <vitus@...1066...>
Message-ID: <20091113122836.GA6902@...1066...>
References: <20091023142219.GA30874@...1066...> <4AE3580C.7080604@...41...>
	<20091026081943.GA29659@...1066...> <4AFC3F83.4090900@...41...>
	<20091112175924.GA10462@...1066...>
	<4AFC530C.9080303@...1114...>
MIME-Version: 1.0
In-Reply-To: <4AFC530C.9080303@...1114...>
Subject: Re: [Openvpn-devel] Character classes in the tls-verify script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On 2009.11.12 at 19:25:16 +0100, David Sommerseth wrote:

> > no-name-remapping  has side effects, i.e. disables system method of
> > script execution. 
> 
> I'd have to disagree here.  OpenVPN should not change the default
> behaviour at all, as that can break a lot of already implemented
> installations if the default remapping goes away.  And forcing values to
> stay inside the 7bit ASCII region is most likely the expected behaviour
> as well.

I doubt so.

If you don't believe me, ask someone whose native language is French or
German and who has characters with umlauts in his name - does he like
this character to be replaced with underscore.

Even for Western Europe restricting character set of certificates to
7-bit is the source of problem, not to mention rest of world, where 
any name would be replaced by string of underscores.

If someone want to limit characters allowed in the certificates, 
it should be done on the CA level, not when parsing certificates.

On this level only reason to map characters is to prevent common
mistakes in the shell script. Characters outside of ASCII range never
can be misinterpreted by shells, so they should be  allowed.

> > Really, I think than name remapping shouldn't be applied to environment
> > variables at all. May be for command line arguments should be protected
> > this way. But people who use environment variables typically are clever
> > enough to  handle shell special characters.
> 
> I am willing to agree with you to some extent here, but OpenVPN cannot
> change the current default behaviour of remapping.  This would have to
> be thought of when this feature was initially implemented in OpenVPN,
> now it is too late to change the defaults.

It is possible to add ADDITIONAL configuration directive such as
--allow-unicode-in-names, which doesn't  have such side-effect as no-name-remapping
does now.

But I think that this should be enabled by default. If someone cannot
handle normal letters, he can disable them.


> Unfortunately, not many thinks about characters outside the standard
> 7bit ASCII.  I've even experienced developers who got non-ASCII

Just all Russia, all Japan and all China.

We just got too tired of persuading english speaking developers, that
world is somewhat bigger than Northern America  and
often prefer to fork and maintain our own localized version of software.


