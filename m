Message-ID: <47B9CC75.2030308@...41...>
Date: Mon, 18 Feb 2008 11:20:37 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <4aff28800802160916r506572a0r44a9e619e31ce5ee@...278...>
	<9e0cf0bf0802160925w2dd86c02mb6f8dd5cfd4ab9e5@...278...>
In-Reply-To: <9e0cf0bf0802160925w2dd86c02mb6f8dd5cfd4ab9e5@...278...>
Subject: Re: [Openvpn-devel] Compiling OpenVPN 2.1rc7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>, Diaa Sami <diaasami@...277...>

The latest Windows build system for OpenVPN is actually quite powerful, 
and can autodetect when certain dependencies are missing, such as the 
Windows DDK, and substitute in a pre-built binary of the driver, instead 
of requiring that every component be built from source.

This means, for example, that if you just want to make a simple change 
to the NSIS script, you don't need to have the DDK installed or build 
OpenSSL, lzo, or PKCS11-Helper.

To build OpenVPN for Windows, use the ./domake-win script.  This script 
has extensive comments, and describes how to use the pre-built binaries 
feature, where pre-built binaries are substituted at every build step 
where a lack of dependencies precludes a build from source.

You can also view the ./domake-win script here:

http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn/domake-win

For example, suppose you want to build a windows installer for OpenVPN 
that includes a custom configuration file and keys.  Here is a 
quick-start guide:

(1) Install the minimum tool chain:

# MinGW     -- for GNU C compiler
# MSYS      -- for bash
# msysDTK   -- for perl
# NSIS      -- for building installer


(2)  Download and expand the prebuilt binaries distribution, for 
example: https://secure.openvpn.net/devel/openvpn-2.1_rc7a-prebuilt.tbz

(3) In the top-level directory of the prebuilt-binary distribution, 
download and expand a source .tar.gz file, for example:
 https://secure.openvpn.net/devel/openvpn-2.1_rc7a.tar.gz

Edit install-win32/settings.in, uncommenting out these lines, and 
setting them to the appropriate file names:

# include a sample configuration file and key
;!define SAMPCONF_DIR   "test-key"
;!define SAMPCONF_CONF  "test.ovpn"
;!define SAMPCONF_P12   "test.p12"
;!define SAMPCONF_TA    "ta.key"

In the commented-out example above, the test-key directory should be 
present in the prebuilt-binaries  top-level directory (the parent 
directory of the source distribution), and should contain the files 
test.ovpn, test.p12, ta.key.

Now you should be able to build an installer with ./domake-win that 
includes these custom configuration files, such that when the installer 
is run by an end-user, these files are placed into \program 
files\openvpn\config

James


