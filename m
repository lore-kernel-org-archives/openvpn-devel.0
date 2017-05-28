References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
	<bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
From: debbie10t <debbie10t@...277...>
Message-ID: <1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
Date: Sun, 28 May 2017 22:36:28 +0100
MIME-Version: 1.0
In-Reply-To: <bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 28/05/17 22:09, David Sommerseth wrote:
> On 28/05/17 22:47, debbie10t wrote:
>> Hi
>>
>> This is just a heads up !
>>
>> I cannot build openvpn on ubuntu 16.04.2 LTS (fresh install) because
>> ./configure --enable-systemd fails to build with the following error:
>>
> [...snip...]
>> checking for libsystemd... no
>> checking for libsystemd... no
>> configure: error: in `/home/dik/openvpn/master':
>> configure: error: The pkg-config script could not be found or is too
>> old.  Make sure it
>> is in your PATH or set the PKG_CONFIG environment variable to the full
>> path to pkg-config.
>>
> [...snip...]
>>
>> $ systemctl version
>> Unknown operation version.
> 
> Can you try --version instead of just 'version'?

oops ..

$ systemctl --version
systemd 229
+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP 
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS 
+KMOD -IDN


sorry about that blunder


> 
>> apt-get install libsystemd-dev is done
> 
> Can you locate libsystemd.pc or systemd.pc on your system?  Are there
> other systemd related -dev packages available?
> 
> 

still looking ..

TYVM

