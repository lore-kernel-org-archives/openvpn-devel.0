Message-ID: <4DCE76E9.4070806@...68...>
Date: Sat, 14 May 2011 14:34:49 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <BANLkTimDEA004RuTcUBKDXPWffEWBo3-iw@...278...>
	<20110514120304.GO8496@...1296...>
In-Reply-To: <20110514120304.GO8496@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] fix 2.2.0 build failure when management
 interface disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 14.05.2011 14:03, schrieb Gert Doering:
> Hi,
> 
> On Wed, May 11, 2011 at 05:57:28PM -0400, Matthew L. Creech wrote:
>> I just upgraded to 2.2.0, and my build fails with:
>>
>> ps.c: In function 'port_share_open':
>> ps.c:778:7: error: 'management' undeclared (first use in this function)
>> ps.c:778:7: note: each undeclared identifier is reported only once for
>> each function it appears in
>> make[5]: *** [ps.o] Error 1
> 
> Thanks for reporting it.  As far as I can see, this problem came in via
> c7dd80cf45efa (aka 2.1.3s), and that is obviously only needed if management
> is enabled.
> 
> So: ACK from me.
> 
> Samuli: we need buildbot variants with/without management, it seems...

Cutting down complexity (i. e. cutting out branches in the decision
and/or option trees) is going to help more than just trying to cure the
symptoms.

-- 
Matthias Andree

