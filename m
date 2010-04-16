From: Davide Brini <dave_br@...1278...>
Date: Fri, 16 Apr 2010 11:02:34 +0100
References: <4BC78077.80301@...1114...>
	<4BC82AF0.5080905@...1114...>
	<20100416093554.GJ12312@...1296...>
In-Reply-To: <20100416093554.GJ12312@...1296...>
MIME-Version: 1.0
Message-Id: <201004161102.34953.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Harden create_temp_filename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Friday 16 Apr 2010 10:35:54 Gert Doering wrote:

> On Fri, Apr 16, 2010 at 11:16:32AM +0200, David Sommerseth wrote:
> > I'll look more into this, as the only advantage is that if open() with
> > O_EXCL|O_CREAT fails if the file exists, it should be used instead.
> 
> Unfortunately, this won't help against symlink attacks directed to
> non-existant files (like "-> /etc/nologin").
> 
> It *will* protect against symlink attacks to existing files (overwriting
> /etc/passwd or something similarily nasty).

"If O_EXCL and O_CREAT are set, and path names a symbolic link, open() shall 
fail and set errno to [EEXIST], regardless of the contents of the symbolic 
link."

Seems to me that it will fail in any case (or at least it should). I may be 
misunderstanding what you mean though.

-- 
D.

