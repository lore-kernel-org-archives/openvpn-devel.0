MIME-Version: 1.0
Sender: ichiga2@...277...
In-Reply-To: <251896ce0904260939w188a31der8e93269f2aac39f3@...278...>
References: <20090424131323.GB21576@...1066...>
	<fa2e1350904240747m2b9a110w471bceb2c335e765@...278...>
	<20090424202940.GA30397@...1066...>
	<251896ce0904250031l5aa2d985r234602e3fbc4d358@...278...>
	<20090426143946.GA17612@...1066...>
	<20090426160734.GA19542@...1066...>
	<251896ce0904260939w188a31der8e93269f2aac39f3@...278...>
Date: Fri, 1 May 2009 01:08:12 +0900
Message-ID: <251896ce0904300908q55adfcf3mb6c8c683eccf1097@...278...>
From: Kazuyoshi Aizawa <admin2@...628...>
Subject: Re: [Openvpn-devel] Solaris questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I modified the build scripts of tun/tap driver for Solaris and
uploaded it to web site below.

  http://www.whiteboard.ne.jp/~admin2/tuntap/

Now, it is capable ..
   to build 32bit module on 64bit environment by using --disable-64bit
option to configure script.
   to checks if ld command is GNU ld or Solaris bundled ld. And then
appends appropriate option for GNU ld.
   to specify target install directory using DESTDIR macro to make command.

Thanks Victor, for the info and help.

Kazuyoshi

