Date: Mon, 26 Apr 2010 09:50:56 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1272210565-9312-1-git-send-email-dave_br@...1278...>
	<201004260956.16533.dave_br@...1278...>
	<4BD56520.9070807@...1114...>
	<201004261148.38378.dave_br@...1278...>
In-Reply-To: <201004261148.38378.dave_br@...1278...> (from dave_br@...1278... on
	Mon Apr 26 05:48:38 2010)
Message-Id: <1272293456.28330.3@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Serial number export, fixed
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

On 04/26/2010 05:48:38 AM, Davide Brini wrote:
> On Monday 26 Apr 2010 11:04:16 David Sommerseth wrote:
> >=20
> > Agreed, but from experience with many users ... it's a lot of users
> who
> > just take a script and try it out without even looking at the=20
> script
> > itself.  So if the script could fail gracefully giving a hint like
> > "you've not done as I told you to", some support issues will be
> avoided.
>=20
> Ok, that makes sense. I didn't look at it this way, but then I
> perfectly know=20
> what you mean, so I'll change it to exit if it detects that something
> is not=20
> set properly.

FWIW, and I don't know what the code does so I can't say
whether this would be useful, but if you go to http://example.com
or http://www.example.com (but not http://foo.example.com) you
get a bare-bones web page explaining that you're using a
reserved domain.



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


