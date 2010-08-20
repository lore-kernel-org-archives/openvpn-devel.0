Message-ID: <20100820153536.14097.qmail@...1287...>
Date: Fri, 20 Aug 2010 17:35:36 +0200
From: Peter Stuge <peter@...1287...>
References: <4C6E73E4.6060300@...515...>
MIME-Version: 1.0
In-Reply-To: <4C6E73E4.6060300@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (19th Aug 2010)
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
> converting the OpenVPN build system (on Windows) to depend only on
> python, Visual Studio Professional and DDK. The original build
> system required bash and various other UNIX tools.

James' mentioned argument for prefering Visual Studio, namely that
MinGW may not have all the most recent functions in .h files, is not
so good IMO. Since James also seems to prefer working outside Windows
I would rather try to make OpenVPN for Windows crosscompileable, both
driver and app.

libusb-win32 can already compile their driver using MinGW.

But maybe that can happen later, any streamlining of builds is a good
thing.


//Peter

