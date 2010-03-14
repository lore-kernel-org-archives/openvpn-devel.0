Date: Sun, 14 Mar 2010 11:50:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100314105002.GB25238@...1296...>
References: <20100314024732.58634.qmail@...1329...>
Mime-Version: 1.0
In-Reply-To: <20100314024732.58634.qmail@...1329...>
Subject: Re: [Openvpn-devel] Compiling openvpn for windows using mingw32
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
To: Kill AllSnoopers <killallsnoopers@...1327...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Mar 14, 2010 at 02:47:32AM -0000, Kill AllSnoopers wrote:
> I am trying to compile openvpn for windows using mingw32 and have openssl lzo, etc compiled. I am trying to compile to create the openvpn.exe and then use the GUI. 

Are you trying to compile natively, or cross-compile?

> I haven't figured how to compile the main openvpn to create openvpn.exe 
> 
> The instructions on openvpn are not that helpful for this part. 
> 
> Can anyone outline the steps or point to mails in the forum that discuss 
> it. I did a search for them without any useful results.

To cross-compile, use Alon's "Build" script, http://opensc-project.org/build
on top of a Linux system of your choice.  To download the script itself,
go to "http://www.opensc-project.org/build/browkser/trunk/build" and then
click on "download in other formats: plain text" at the end.


If you want to compile natively on windows, install mingw + msys, and
then follow the instructions in "domake-win" in the OpenVPN source 
tree (it's the script to run, and it has lots of documentation inside
how to get the required components).

Building for Windows is not something for the faint of heart, or for
unexperienced package builders.  Expect build failures, and expect to
read other people's scripts and figure out what is failing and what you
need to add to your build environment to make it work.


If you ask this list, better include a full description of what you did,
on which platform, and what error message resulted - otherwise we're not
able to give useful advice.

(Out of personal curiousity: why are you trying to build-your-own?  The
precompiled packages work perfectly well...)

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

