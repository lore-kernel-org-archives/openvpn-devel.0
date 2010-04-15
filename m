Message-ID: <20100415012851.24005.qmail@...1287...>
Date: Thu, 15 Apr 2010 03:28:51 +0200
From: Peter Stuge <peter@...1287...>
References: <4BC5B0CF.4030607@...515...>
MIME-Version: 1.0
In-Reply-To: <4BC5B0CF.4030607@...515...>
Subject: Re: [Openvpn-devel] Finnish translation of OpenVPN-GUI for review
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Samuli Seppänen wrote:
> Btw. this translation file format is by far the most difficult one
> I've ever worked with.

Probably because it isn't a translation file format at all. :)

This is the file format used by the Windows Resource Compiler to
turn "resources" such as dialogs or files into object form that can
be linked with an app and referenced easily from within the app.

The resource compiler supports #include but I don't know if any other
CPP features work. At least it would be possible to move all texts to
a separate file.


//Peter

