From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] correction for init script for SuSE
In-Reply-To: <41BDD765.4010107@...324...>
Message-ID: <Pine.LNX.4.58.0412131604360.26365@...41...>
References: <41BDD765.4010107@...324...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Dec 13 15:06:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Stefan Engel <mail@...324...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 13 Dec 2004, Stefan Engel wrote:

> Hi,
> 
> the init script for SuSE (source in suse/openvpn.init) contains a bug
> regarding the location of the openvpn binary when used in an RPM.
> If OpenVPN is built using rpm then the resulting binary is installed
> as /usr/sbin/openvpn. The init script contains the following lines
> 
>  > # Location of openvpn binary
>  > openvpn="/usr/local/sbin/openvpn"
> 
> /usr/local/sbin/openvpn may be valid when installing from tar.gz, but
> not if using rpm.
> 
> Attached is a patch against openvpn.spec in 2.0rc3 which should fix
> this.

Thanks, I will merge for rc4.

James


