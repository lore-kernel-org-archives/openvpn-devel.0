From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] Fwd: Re: comp-lzo and licensing issues
In-Reply-To: <20030428142748.GA826@...30...>
Message-ID: <Pine.LNX.4.50.0304281058060.7360-100000@...48...>
References: <20030428142748.GA826@...30...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Apr 28 08:08:22 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...5...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Mon, 28 Apr 2003, Alberto Gonzalez Iniesta wrote:

> Hi all,
>
> Sorry for the huge forward, but everything needed to understand this
> problem should be there :)
>
> GPL software does not mix well with OpenSSL, and that's giving me some
> headaches lately. As you me see in my mail to Markus (liblzo author) and
> James (we all know who he is :) linking liblzo with OpenSSL may be a GPL
> violation [1].
>
> So this is a call for comments on this issue.
> Can anybody reach Markus and comment him about this?
> Should we switch to another compression library? In that case, which one
> would be suitable? zlib?
> Should we ignore this and let RMS jump on us? [2]

Well zlib could be suitable, considering that OpenVPN does implement some
reliable UDP stuff for SSL/TLS type streams to work correctly.  Of course
it might be a performance hit.  On the other hand, if you are linking it
yourself and not redistributing the binaries you are probably okay.  This
means though that prebuilt binaries linked to liblzo could be a no-no.

Of course the slope gets slippery if OpenSSL is shipped with the OS by
default and is considered a 'system library'.  In such case it might not
necessarly be a violation, otherwise linking GPL software on a system like
Solaris and distribution the resulting binaries would be forbidden as
well.

Of course another option here is to consider getting OpenVPN to play nice
with gnutls, though I am not familiary with the maturity of that piece of
software.

Regards,

Aaron

