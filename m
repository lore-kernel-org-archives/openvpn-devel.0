References: <cover.1487368114.git.logout@...260...>
	<a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
	<20170223080347.GA56089@...1296...>
	<20170223092314.GR93896@...1296...>
	<CAKh=nwFfZrDu-Q_ctgyZ=aq83GjxgBfDyauLPOmzDjXbSHdxrg@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <88341ddd-b130-8970-c8ab-885c27af8b73@...1435...>
Date: Thu, 23 Feb 2017 10:36:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAKh=nwFfZrDu-Q_ctgyZ=aq83GjxgBfDyauLPOmzDjXbSHdxrg@...278...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 01/15] OpenSSL: don't use direct
 access to the internal of SSL_CTX
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 23-02-17 10:31, Emmanuel Deloget wrote:
>>>  - configure.ac does something to CentOS 6 / RHEL 6 which makes configure
>>>    explode:
>>>
>>> ...
>>> checking for linux/if_tun.h... yes
>>> checking tap-windows.h usability... no
>>> checking tap-windows.h presence... no
>>> checking for tap-windows.h... no
>>> checking whether TUNSETPERSIST is declared... yes
>>> checking for setcon in -lselinux... yes
>>> checking for pam_start in -lpam... yes
>>> checking for PKCS11_HELPER... no
>>> ./configure: line 21440: syntax error near unexpected token `fi'
>>> ./configure: line 21440: `fi'
>>
>> This still needs investigation.
> 
> I'm taking the time to install a CentOS 6 on a VM. I'll test this asap.

I have a fix ready, but am busy with testing it on various platforms.

-Steffan


