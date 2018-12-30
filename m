References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <ca4da521-e34e-3113-6dfe-bf1a33a19b90@...277...>
 <6126e9fd-4858-65d5-8c88-e9ea9d4ddde0@...515...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <878d0181-5b08-36ea-da5a-825cd365b74b@...277...>
Date: Sun, 30 Dec 2018 18:22:30 +0000
MIME-Version: 1.0
In-Reply-To: <6126e9fd-4858-65d5-8c88-e9ea9d4ddde0@...515...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

Hi,

On 30/12/2018 14:56, Samuli Seppänen wrote:
> Hi,
> 
> Il 29/12/18 22:06, tincanteksup ha scritto:
>>

>>   debian/rules clean
>> dh clean
>> make: dh: Command not found
> 
> Package "debhelper" is missing. When using Vagrant debhelper gets
> installed in the provisioning script:
> 
>    https://github.com/mattock/openvpn-vagrant/blob/sbuild/sbuild.sh
> 
> That provisioning script should run fine on any Ubuntu 18.04 VM, not
> just inside Vagrant/Virtualbox.

Yes, it all works now.


