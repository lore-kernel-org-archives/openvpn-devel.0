Message-ID: <4A700539.7040505@...1114...>
Date: Wed, 29 Jul 2009 10:15:53 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1248832199.19514.1@...1207...>
In-Reply-To: <1248832199.19514.1@...1207...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

On 29/07/09 03:49, Karl O. Pinc wrote:
> On 07/28/2009 04:22:09 PM, Sebastien Raveau wrote:
> 
> 
>> If I understand you correctly, that is, if you are suggesting that
>> OpenVPN should automatically apply a SELinux context if setcon() is
>> available... I'll have to disagree with you. Not that I reject the
>> idea of enforcing security measures by default, but because when you
>> google for "selinux howto", half of the first-page results are on how
>> to *disable* SELinux. Apparently not everybody likes it, and they 
>> have
>> a right to, so I believe we should not force it upon them :-)
> 
> SELinux is a great idea, in theory.  In practice I find the
> cost/benefit such that I wind up turning it off.  I'd love
> to have it available and working in "stock" situations,
> and have the (easy to do) option of turning it off if
> desired.   If nothing else it gets in the way of development/
> deployment.  After something's working then it's possible to go back
> and figure out which permissions need enabling.

I've been running Fedora with SELinux enabled for over a year, without
having any issues at all.  I've even been testing a lot of different
software setups on Fedora and Red Hat Enterprise Linux, without having
issues.

> Because of the complication it would also be highly
> desirable, except for a possible "off/monitor mode/on"
> switch, if it would integrate with the rest of SELinux
> so there's not yet more configuration.  I assume that
> this is the natural approach to take, but figured I'd
> mention it anyway.

In Fedora/RHEL you have the getenforce and setenforce programs, which
changes between "Permissive" and "Enforced" modes.  This is a
system-wide configuration change, and is effective immediately without
reboot.  With a properly designed SELinux profile for OpenVPN, usually
from a distribution, but it would be good if it also followed the
OpenVPN source code, it would not be more configuration.  It would be to
register this profile on your system.  Normally, these profiles can be
quite static, no matter which system it is setup on.  On a brand new
installation, it might be needed to label some files on the file system,
but again, this could be done via a little script.  New configuration
files for OpenVPN and certificates would need to be labelled too, but
that's usually just to either copy them into the desired directory and
to run restorecon or chcon.

http://danwalsh.livejournal.com/4208.html

In fact, Fedora and RHEL do ship OpenVPN 2.1_rc15 with SELinux profiles,
labelling files and directories for OpenVPN.  But there is no security
context shift inside the binary, AFAIK, which would be even more
beneficial, as not everything is covered by just file labelling.


kind regards,

David Sommerseth


