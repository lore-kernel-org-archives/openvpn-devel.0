Message-ID: <55922EC6.6050908@...1227...>
Date: Tue, 30 Jun 2015 07:53:10 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1435581995-11820-1-git-send-email-arne@...1227...>
	<20150629182224.GN382@...1296...>
In-Reply-To: <20150629182224.GN382@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Report missing endtags of inline files
 as warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 29.06.15 um 20:22 schrieb Gert Doering:
> Hi,
>
> On Mon, Jun 29, 2015 at 02:46:35PM +0200, Arne Schwabe wrote:
>>  	}
>>        buf_printf (&buf, "%s", line);
>>      }
>> +  if (!endtagfound)
>> +    msg (M_WARN, "WARNING: Endtag %s missing", close_tag);
> Generally speaking, ACK.  I wonder whether this should be M_WARN or
> M_FATAL, though?
>
> Tested, nicely reports the missing </key> in my test case, but then
> proceeds to "not do what the user intended"...
>
> (Can't commit it anyway, as mid.gmane.org is not giving me URLs right now...)
>
Maybe M_WARN for 2.3, M_FATAL for 2.4?

Arne

