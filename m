References: <1444156707-14087-1-git-send-email-steffan@...1856...>
	<20151008064333.GR22054@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56161D90.7040101@...1227...>
Date: Thu, 8 Oct 2015 09:38:56 +0200
MIME-Version: 1.0
In-Reply-To: <20151008064333.GR22054@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] openssl: be less verbose about cipher
 translation errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Am 08.10.15 um 08:43 schrieb Gert Doering:
> Hi,
> 
> On Tue, Oct 06, 2015 at 08:38:27PM +0200, Steffan Karger wrote:
>> Translation errors are usually not a real problem, since we don't maintain
>> the complete list of ciphers OpenSSL supports.  So, be less verbose if we
>> can not find a translation.
> 
> I wonder what the motivation on this one is.  If the user requests a 
> certain cipher, and we can't give it to him - shouldn't this be warned
> about quite prominently?
> 

The user request a cipher that exists, but is not our translation table.
Gets a confusion error message.

Arne


