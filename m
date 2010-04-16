Date: Fri, 16 Apr 2010 11:35:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100416093554.GJ12312@...1296...>
References: <4BC78077.80301@...1114...> <4BC81AED.8010206@...1338...>
	<4BC824D3.8000008@...1114...>
	<4BC82AF0.5080905@...1114...>
Mime-Version: 1.0
In-Reply-To: <4BC82AF0.5080905@...1114...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Apr 16, 2010 at 11:16:32AM +0200, David Sommerseth wrote:
> I'll look more into this, as the only advantage is that if open() with
> O_EXCL|O_CREAT fails if the file exists, it should be used instead.

Unfortunately, this won't help against symlink attacks directed to
non-existant files (like "-> /etc/nologin").  

It *will* protect against symlink attacks to existing files (overwriting
/etc/passwd or something similarily nasty).

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

