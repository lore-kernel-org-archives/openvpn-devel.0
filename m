Subject: Re: [Openvpn-devel] OpenVPN multi instancing
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1078254620.7193@...41...>
In-Reply-To: <20040302101450.GA7745@...33...>
References: <200402291538.45014.cd@...154...> <twig.1078170122.8125@...41...>, <twig.1078170122.8125@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Mar  2 11:16:09 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias Andree <ma+ovpnd@...31...> said:

> On Mon, 01 Mar 2004, James Yonan wrote:
> 
> > Christian Daniel <cd@...154...> said:
> > 
> > > Hello everybody!
> > > 
> > > For a student research project I'm trying to add multi instance
capability to 
> > > OpenVPN. The basic idea is to rip the main openvpn()-function apart, put
all 
> > > variables in a struct and then have only one select()-call for all open 
> > > tunnels at once.
> > 
> > It's already been done :)
> > 
> > See the BETA20 branch in the CVS.
> 
> Is there a document that mentions the development tags so the daring
> know what to check out? Or a mailing list I should subscribe to?

It's not too complicated.  The HEAD branch is stable, or a beta series which
is leading to a stable release, i.e. 1.6-betaX.  The BETA20 branch at this
point mostly contains a lot of refactorization.  All the stuff that used to be
on the stack in the openvpn() function is now kept in a struct context. 
openvpn.c and the main() function is clean and minimalistic once again.

Every major or beta release gets a tag that is constructed from the version
number.  When I do a cvs commit I use this simple script:

cvs commit -m "version $OPENVPN_VER" && cvs tag `echo openvpn-$OPENVPN_VER |
tr . -`

where $OPENVPN_VER is something like "1.6-beta7" or "1.5.0".

> May I suggest to post the pointer to the document or add one to
> openvpn.sourceforge.net?

There's not a lot of people actually working on the code right now, so it's
easier to just ask questions on the list or search the archives.

James


