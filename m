Date: Fri, 16 Apr 2010 12:39:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100416103905.GK12312@...1296...>
References: <4BC78077.80301@...1114...>
	<4BC82AF0.5080905@...1114...>
	<20100416093554.GJ12312@...1296...>
	<201004161102.34953.dave_br@...1278...>
Mime-Version: 1.0
In-Reply-To: <201004161102.34953.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Harden create_temp_filename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Apr 16, 2010 at 11:02:34AM +0100, Davide Brini wrote:
> > Unfortunately, this won't help against symlink attacks directed to
> > non-existant files (like "-> /etc/nologin").
> 
> "If O_EXCL and O_CREAT are set, and path names a symbolic link, open() shall 
> fail and set errno to [EEXIST], regardless of the contents of the symbolic 
> link."

Oh?  One learns something new every day :-) - just checked with the FreeBSD
manpage, and it's even more explicit:

     If O_EXCL is set and
     the last component of the pathname is a symbolic link, open() will fail
     even if the symbolic link points to a non-existent name.

- so please disregard my comment.  Everything is fine.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

