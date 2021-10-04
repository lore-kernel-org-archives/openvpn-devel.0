References: <YVrc/1PV72e1WcNC@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <77dfa790-43e3-5d75-e153-e393d03ac6de@...1227...>
Date: Mon, 4 Oct 2021 13:23:46 +0200
MIME-Version: 1.0
In-Reply-To: <YVrc/1PV72e1WcNC@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [dbelyavs@...1347...: OpenSSH with OpenSSL 3.0:
 preventing loss of remote access]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 04.10.21 um 12:52 schrieb Gert Doering:
> Hi,
> 
> (this is mainly for Arne and Selva, but I've decided to post it to
> the list to raise awareness).
> 
> OpenSSL 3.0 seems to bring "interesting" surprises with their provider
> thingie, and openssl.cnf - not sure if this is at all relevant for 
> OpenVPN, but it sounds as if it might be.
> 

I accidentality tested this and OpenVPN just exits very early with an
assertation that RAND_bytes fails. So I don't consider this to be a problem.

Arne

