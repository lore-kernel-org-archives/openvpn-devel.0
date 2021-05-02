References: <20210501130640.9330-1-a@...2181...>
 <20210501130640.9330-4-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <41aea59e-f3dd-4d84-b570-f88fa48da5ba@...1227...>
Date: Sun, 2 May 2021 14:14:08 +0200
MIME-Version: 1.0
In-Reply-To: <20210501130640.9330-4-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 3/3] windows: list all enum values in
 switch block
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>

Am 01.05.21 um 15:06 schrieb Antonio Quartulli:
> From: Antonio Quartulli <antonio@...515...>
> 
> A switch block in interactive.c is missing the _undo_type_max value
> of the neum set, thus triggering a compiler warning.
> 
> Due to the logic, this value cannot really be assigned to the variable
> being examinated, however, add the missing enum value to silence
> the warning.
> 
> Fixes:
> 
> interactive.c: In function ‘Undo’:
> interactive.c:1561:13: warning: enumeration value ‘_undo_type_max’ not handled in switch [-Wswitch]
>  1561 |             switch (type)
>       |             ^~~~~~
> 
>

Acked-By: Arne Schwabe <arne@...1227...>

