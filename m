Date: Mon, 1 Jun 2009 16:51:31 +0400
From: 'Victor Wagner' <vitus@...1066...>
Message-ID: <20090601125130.GA26473@...1066...>
References: <20090601051543.GA15965@...1066...>
	<066077553B6D451A8727FFA24F09AC1C@...576...>
MIME-Version: 1.0
In-Reply-To: <066077553B6D451A8727FFA24F09AC1C@...576...>
Subject: Re: [Openvpn-devel] Unable to use -OFB or -CFB ciphers in	OpenVPN
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

On 2009.06.01 at 07:45:13 -0500, dave wrote:

> I would suspect that the exclusion is due to:
> 
> A)  in CFB/OFB/CNT, the encrypted stream is byte-bounded, as opposed to
> block-bounded.  There may be some assumptions in the code that assume
> the cipher text is a multiple of block lengths.  As such, it is...

It is valid argument. Is there some quick way to find out suspicious
places in the code? Some amount of false positives is Ok.
 
> B)  not thoroughly tested, and the choice was made to not release it
> without such testing.

As far as I can see, openvpn can be thoroughly tested in automated
fashion. I have some test farm with half a hundred various OSes (Linux,
Windows, Solaris, FreeBSD on several architectures), and planning to 
do some openvpn testing for this platform anyway. 

If people would suggest me which things to test, I'll try to implement
it in the automated test environment.


> I'm curious as to why you want this support specifically, since these
> modes aren't really faster than CBC.  Are you concerned about the
> padding?

I've stated it clearly. There is no CBC in the Russian National Standard
for symmetric ciphers. CFB is standartized, CNT is standartized, CBC is
not. So, if I want my VPNs to be considered secure by goverment
certification authorites, I have to use CFB or CNT.



> 
> -dave
> 

