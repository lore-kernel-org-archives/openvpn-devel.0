Date: Wed, 12 Jan 2011 10:13:21 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4D2D68E0.9080702@...68...> (from matthias.andree@...68... on Wed
	Jan 12 02:40:00 2011)
Message-Id: <1294848801.8189.4@...1207...>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Cc: openvpn-devel@lists.sourceforge.net

On 01/12/2011 02:40:00 AM, Matthias Andree wrote:
> Am 11.01.2011 12:20, schrieb David Sommerseth:
> >=20
> > Hi folks!
> >=20
> > This is a little cry for help from us playing with the OpenVPN=20
> code.
> >=20
> > We have a quite good man page today with a lot of information.  But
> > maintaining it and to make sure it is up-to-date with all the
> features
> > OpenVPN supports is often not high up on the priority list.=20

Don't accept a patch unless the documentation is also patched?

 In
> > addition, the current format (one single file, in pure man page
> format)
> > is getting harder and harder to maintain as well.
> >=20
> > So, we're hoping some people with some English skills is interested
> to
> > help out improving this situation.  What we immediately would like
> to
> > see is something along these lines:
> >=20
> > * Move the man page to a better format than the pure man page
> format.
> >   Are there some good tools/formats like ascii2man or DocBookXML
> which
> >   could help easing the maintenance of our documentation?
>=20
> Docbook XML for sure is a lot more verbose than asciidoc or roff.  I
> would tend
> to avoid Docbook, the toolchains are lacking a bit -- still :-(
> although xmlto +
> fop can yield reasonable PDF results.

This is a matter of taste.  I'd turn that on it's head and say
that Docbook is a lot more clear than roff.  How hard is stuff
like:
<section>
<title>Overview</title>
...
</section>
With an editor like emacs or lyx it's not even much more typing=20
and you get built-in validation, etc.

I'm not sure I understand the tool criticism.  There's pdf and
html and all the other basic outputs.  You can use the
xinclude mechanism  to produce different documents from=20
components broken into files.  So there can be a man page,
a reference book, a "pocket reference" with just a table
of arguments, etc, some content of which is shared and
some of which is unique to each document.  If you=20
like you've all of xml and xslt
and so forth to manipulate the documents dynamically allowing
you to, say, suck an example configuration straight out of
the documentation into a text file to be distributed in
an examples directory to be installed with openvpn.
This way you don't maintain the same example in two places.

>=20
> However, we should make sure that there still is something that works
> with "man".

Docbook should do man.  I've never actually done it but
here's a whole series of tags that=20
support all the man-like formatting at the top of the man page
what with marking each argument etc.
Frankly, that's where you'll see the ugly verbosity.  Plain old
paragraphs and so forth are plainless.  But once the top of the
man page is done once you pretty much don't have to make changes
or if you do then you've an example to work from.




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


