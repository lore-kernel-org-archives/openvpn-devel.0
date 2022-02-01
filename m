Message-ID: <df92b47a-0c1d-d917-d919-45a350a1607e@...2080...>
Date: Tue, 1 Feb 2022 16:20:49 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220114171446.26446-1-a@...2181...>
 <849ad997-ee48-89ba-00a5-98a98c8e33ba@...2181...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <849ad997-ee48-89ba-00a5-98a98c8e33ba@...2181...>
Subject: Re: [Openvpn-devel] [RFC v2 0/7] Introduce ovpn-dco(-win) support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

On 01/02/2022 15:56, Antonio Quartulli wrote:
> 
> * COPR repo (Fedora, CentOS, RHEL)
> ** for openvpn2: 
> https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-dco/
> ** for ovpn-dco: https://copr.fedorainfracloud.org/coprs/dsommers/openvpn3/

Just a few quick steps on how to test this on Fedora and RHEL (with clones).

First, ensure you have the a functional 'yum copr' command.  This is 
normally available by default on Fedora and RHEL-8 and up.

Then run these commands:

    # yum copr enable dsommers/openvpn-dco
    # yum copr enable dsommers/openvpn3
    # yum install kmod-ovpn-dco openvpn

Then you can put your server configs into /etc/openvpn/server and client 
configs into /etc/openvpn/client.

To start the OpenVPN server:

     # systemctl enable --now openvpn-server@...2562...

To start the OpenVPN client:

     # systemctl enable --now openvpn-client@...2562...

These steps will also start OpenVPN automatically upon boot.  If you 
don't want that, just replace 'enable --now' with 'start'.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


