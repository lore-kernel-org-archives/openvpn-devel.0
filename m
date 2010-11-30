Message-ID: <4CF52034.6090108@...68...>
Date: Tue, 30 Nov 2010 17:03:00 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4CED2879.2030009@...1432...>
	<4CF51D5B.4090905@...68...>
In-Reply-To: <4CF51D5B.4090905@...68...>
Subject: Re: [Openvpn-devel] use extv3 extensions such as subjectAltName as
 common_name
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
To: openvpn-devel@lists.sourceforge.net

Am 30.11.2010 16:50, schrieb Matthias Andree:
> Make sure that the extraction reports failure (aka "return false;") and the
> caller deals with that in case there are embedded NULs, IOW strlen() != ia5.size.

That ia5.size should be read as "ia5->length". Sorry for the confusion.

-- 
Matthias Andree

